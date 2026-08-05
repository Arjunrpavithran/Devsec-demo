pipeline {
    agent any

    environment {
        DEPLOY_ENV  = 'qa'
        sonar_token = 'sqa_c4f6e3a8ba0bb09897b8878db8595cc5948658a9'
        sonar_host  = 'http://host.docker.internal:9000'
        project_name = 'devsecops-demo-app'
		app_name = 'devsec-test'
		
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
			
        // stage('Run SonarQube Scan') {
        //     steps {
        //         sh """
        //             docker run --rm \
        //                 -v ${WORKSPACE}:/usr/src \
        //                 sonarsource/sonar-scanner-cli \
        //                 -Dsonar.projectKey=${project_name} \
        //                 -Dsonar.sources=/usr/src \
        //                 -Dsonar.host.url=${sonar_host} \
        //                 -Dsonar.login=${sonar_token}
        //         """
        //     }
        // }
		stage('Docker image build'){
			steps{
				sh """
					docker build -f \
					${WORKSPACE}/Dockerfile \
					-t ${app_name} \
					${WORKSPACE}
			    """
			}
		}
		// stage ('Trivy image scan'){
		// 	steps{
		// 		sh """
		// 			trivy image ${app_name}
		// 		"""
		// 	}
		// }
		stage('docker push'){
			steps{
				withCredentials([usernamePassword(credentialsId: 'docker_hub_cred', usernameVariable: 'docker_username', passwordVariable: 'docker_password' )]){
				sh'''
				echo "$docker_password" | docker login -u "$docker_username" --password-stdin
				docker tag ${app_name} ${docker_username}/${app_name}
				docker push ${docker_username}/${app_name}
				'''
				}
				
			}
		}
		stage('Deploy to kube'){
			steps{
				withCredentials([file(credentialsId: 'docker_desktop_config', variable: 'DOCKER_CONFIG_FILE')]) {
                    sh '''        
                        mkdir -p ~/.kube
                        cp "$DOCKER_CONFIG_FILE" ~/.kube/config
        
                        kubectl config view
                        kubectl get namespaces
                    '''
 				    // sh '''
                    // mkdir -p ~/.kube
                    // cp "$DOCKER_CONFIG_FILE" ~/.kube/config
                    // chmod 600 ~/.kube/config
                    // kubectl get namespaces
	            	// '''
				}
			}
		}
	}
}