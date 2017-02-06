# Sakai Translations Pipeline
Keep sakai translations up to date.
This project allows you to use a Jenkins server to download translations and create a patch ready to apply in order to keep sakai translations updated.

# Installation
- Install a Jenkins 2.x server with pipeline plugins (default installation).
- You also need python available to run transifex scripts and git 1.7.8 or above.
- Add _Pipeline Utility_ Steps plugin.
- Add _HTML Publisher_ plugin.
- Create a Multibranch Pipeline job in Jenkins.
- Set this repo url as source url (or your own fork).
- Change the translation.properties to add your LOCALE (it must be supported locale in transifex sakai project)

# Run
After running master and 11.x branch, you'll have one file for each LOCALE with the patch to apply in Sakai in order to update translations. The job only export reviewed translations from transifex.
