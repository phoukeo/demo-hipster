podTemplate(containers: [
    containerTemplate(name: 'anthos', image: 'thilavanh/jenkins-slave-k8s', ttyEnabled: true, command: 'cat')
  ]) {

    node(POD_LABEL) {
        stage('Get an Anthos project') {
            container('anthos') {
                stage('Build an Anthos project') {
                  git 'https://github.com/phoukeo/demo-hipster.git'
                  withCredentials([file(credentialsId: 'user1-anthos-ansiblized-kubeconfig', variable: 'KUBECONFIG1')]) {
                      sh """
                      export KUBECONFIG=$KUBECONFIG1
                      cd hipster-all-deploy && ./deploy.sh
                      """
                    }
                }
            }
        }
    }
}
