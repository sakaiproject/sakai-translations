properties([[$class: 'BuildDiscarderProperty',
                strategy: [$class: 'LogRotator', numToKeepStr: '5']],
                pipelineTriggers([cron('@midnight')]),
                ])

node {

	// First checkout the code
	stage ('Checkout') {
	
		// Checkout the source from sakai-translations.
		checkout scm
	   	// Checkout code from sakai repository
	   	dir('sakai') {
	   		git ( [url: 'https://github.com/sakaiproject/sakai.git', branch: env.BRANCH_NAME] )
		   	dir('l10n') {
		   		git url: 'https://github.com/JaSakai/l10n.git'
		   	}
	   	}
	   	
	}

	// Read properties after checkout
	def props = readProperties  file: 'translation.properties'
	def transifex_project = props['PROJECTNAME']
	def locales = props['LOCALES'].split(',')

   	// Now run init transifex 
   	stage ('Init Transifex') {
   		env.TRANSIFEX_SAKAI_PROJECTNAME='${transifex_project}'
	   	dir ('sakai/l10n') {
	   		sh "echo -e '\n' | python tmx.py init"
	   	}
	}
	
	// Now download translations from transifex
	stage ('Download Translations') {
		env.TRANSIFEX_SAKAI_PROJECTNAME='${transifex_project}'
	   	dir ('sakai') {
	   		dir ('l10n') {
	   			for (String locale:locales) {
	   				sh "python tmx.py download -r -u -c -l ${locale}"
	   			}
	   		}
	   		for (String locale:locales) {
	   			sh "git add -N '*_${locale}.properties'"
	   			sh "git diff -- '*_${locale}.properties' > ../translation_${locale}.patch"
	   		}
	   	}
	}   	
	   	
	stage ('Publish Patches') {
	
		for (String locale:locales) {
			publishHTML(
				[allowMissing: false, 
				 alwaysLinkToLastBuild: false, 
				 keepAll: false, 
				 reportDir: '.', 
				 reportFiles: 'translation_${locale}.patch', 
				 reportName: 'TranslationPatch_${locale}'])
		}
				
	}
}
