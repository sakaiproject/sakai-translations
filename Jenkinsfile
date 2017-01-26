node {
	// First checkout the code
	stage 'Checkout'
	// Checkout the source from sakai-translations.
	checkout scm
   	// Checkout code from sakai repository
   	dir('sakai') {
   		git ( [url: 'https://github.com/sakaiproject/sakai.git', branch: 'master'] )
	   	dir('l10n') {
	   		git url: 'https://github.com/JaSakai/l10n.git'
	   	}
   	}
   	sh "ls -la sakai"
}
