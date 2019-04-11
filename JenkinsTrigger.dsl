// trigger job runs from the github webhook
// scripted pipeline, will run other jobs for me

def target_branch = "master"
def pull_num = 0
def action = "test"
def toolchains = ['gcc_arm'] 	// armc6 and iar to come
def targets = ['NRF52_DK']	//

node ("GCC_ARM") {
    stage ("Print ENV") {
		echo sh(returnStdout: true, script: 'env | sort')
    }
	stage ("Detection") {
		script{
			if (env.CHANGE_AUTHOR) {
				// Pr trigger from Github webhook
				echo "Pull request: ${env.CHANGE_URL}"
				target_branch = env.CHANGE_TARGET
				pull_num = env.CHANGE_URL.split('/')[-1]
			} else {
				// nightly or manual trigger
				echo "Cause: ${currentBuild.rawBuild.getCauses()[0].toString()}"
				if ( currentBuild.rawBuild.getCauses()[0].toString().contains('UserIdCause') ){
					// Manual trigger
					echo "Manual"
				} else {
					// Nightly
					echo "Nightly"
				}
			}
		}
	}
}

