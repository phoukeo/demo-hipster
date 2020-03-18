podTemplate(
  cloud: 'kubernetes',
  containers: [
      containerTemplate(name: 'anthos', image: 'thilavanh/jenkins-slave-k8s', ttyEnabled: true, command: 'cat')
    ]) {

      node(POD_LABEL) {
          stage('Get an Anthos project') {
              container('anthos') {
                  stage('Build an Anthos project') {
                    git 'https://github.com/phoukeo/demo-hipster.git'
                    withCredentials([
                      file(credentialsId: 'user1-anthos-ansiblized-kubeconfig', variable: 'KUBECONFIG1'),
                      file(credentialsId: 'pt-was-not-here-kubeconfig', variable: 'KUBECONFIG2')])
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

// podTemplate(
//   cloud: 'kubernetes-test',
//   containers: [
//       containerTemplate(name: 'anthos', image: 'thilavanh/jenkins-slave-k8s', ttyEnabled: true, command: 'cat')
//     ]) {
//
//       node(POD_LABEL) {
//           stage('Get an Anthos project') {
//               container('anthos') {
//                   stage('Build an Anthos project') {
//                     git 'https://github.com/phoukeo/demo-hipster.git'
//                     withCredentials([file(credentialsId: 'pt-was-not-here-kubeconfig', variable: 'KUBECONFIG2')]) {
//                         sh """
//                         export KUBECONFIG=$KUBECONFIG2
//                         cd hipster-all-deploy && ./deploy-test.sh && ./deploy-prod.sh
//                         """
//                       }
//                   }
//               }
//           }
//       }
//   }
