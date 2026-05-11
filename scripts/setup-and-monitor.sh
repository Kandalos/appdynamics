set -e  # Stop immediately if any command fails
# 1. Make absolutely sure we're in an 'appdynamics' directory
[[ "$PWD" == appdynamics ]] || { echo "ERROR: Not in appdynamics dir. Exiting."; exit 1; }
# 2. Remove old -disabled dirs (ignore errors if none exist)
find . -maxdepth 1 -type d -name '-disabled' -exec rm -rf {} + 2>/dev/null; true
# 3. Rename current Tomcat dirs to <name>-disabled
find . -maxdepth 1 -type d ! -name "." ! -name "*-disabled" -exec mv {} {}-disabled \;
# 4. Extract new agent
unzip -o Appdynamics-App-Agent.zip -d temp_extract
# 5. Create fresh Tomcat dirs and copy new agent into them
find . -maxdepth 1 -type d -name "Tomcat[0-9][0-9][0-9][0-9]*-disabled" | \
  sed 's/-disabled$//' | \
  xargs -I {} sh -c 'mkdir -p "{}" && cp -r temp_extract/* "{}"/'
# 6. Restore controller-info.xml from the old (disabled) configs
find . -maxdepth 1 -type d -name "Tomcat[0-9][0-9][0-9][0-9]*-disabled" | \
  sed 's/-disabled$//' | \
  xargs -I {} sh -c '[ -f "{}-disabled/conf/controller-info.xml" ] && cp "{}-disabled/conf/controller-info.xml" "{}/conf/"'
# 7. Clean up
rm -rf temp_extract
echo "All done. New agents are in place."
