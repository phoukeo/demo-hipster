podTemplate(
  cloud: 'kubernetes',
  containers: [
      containerTemplate(name: 'anthos', image: 'thilavanh/jenkins-slave-k8s', ttyEnabled: true, command: 'cat')
    ]) {

      node(POD_LABEL) {
          stage('Get an Anthos project') {
              container('anthos') {
                  stage('Install Hipster Demo Application') {
                    git 'https://github.com/phoukeo/demo-hipster.git'
                    withCredentials([
                      file(credentialsId: '"${cluster1}"', variable: 'KUBECONFIG1'),
                      file(credentialsId: '"${cluster2}"', variable: 'KUBECONFIG2')])
                     {
                        sh """
                        cd hipster-all-deploy
                        export KUBECONFIG=$KUBECONFIG1
                        ./deploy.sh
                        export KUBECONFIG=$KUBECONFIG2
                        ./deploy.sh
                        """
                      }
                  }
              }
          }
      }
  }
