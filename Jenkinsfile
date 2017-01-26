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
	   	
   	// Now run init transifex 
   	stage 'Init Transifex'
   	
	   	dir ('sakai/l10n') {
	   		sh "echo -e '\n' | python tmx.py init"
	   	}

	// Now download translations from transifex
	stage 'Download Translations'

	   	dir ('sakai') {
	   		dir ('l10n') {
	   			sh "python tmx.py download -r -u -c -l es"
	   		}
	   		sh "git diff > ../translation_es.patch"
	   	}
	   	
	   	
	stage 'Save Patches'
	
		archiveArtifacts 'translations_*.patch'
}
