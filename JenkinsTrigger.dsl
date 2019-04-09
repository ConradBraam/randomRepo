// trigger job runs from the github webhook
// scripted pipeline, will run other jobs for me

node ("GCC_ARM") {
    stage ("Print ENV") {
		echo sh(returnStdout: true, script: 'env | sort')
    }
}

