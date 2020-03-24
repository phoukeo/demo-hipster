podTemplate(
  cloud: 'kubernetes',
  containers: [
      containerTemplate(name: 'anthos', image: 'thilavanh/centos-kubectl', ttyEnabled: true)
    ]) {

      node(POD_LABEL) {
        parameters {
          choice(name: 'mode', choices: ['apply', 'delete'], description: 'apply, delete' )
          choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')
          credentials(name: 'cluster1', defaultValue: "user1-anthos-ansiblized-kubeconfig", description: 'Your User Cluster1', credentialType: "Secret file", required: true)
          credentials(name: 'cluster2', defaultValue: "chicken-crossed-the-road-kubeconfig", description: 'Your User Cluster2', credentialType: "Secret file", required: true)
        }
          stage('Get an Anthos project') {
              container('anthos') {
                  stage('Install Hybrid Hipster Demo Application') {
                    // git (url: 'https://github.com/phoukeo/demo-hipster.git', credentialsId: 'phoukeo-github')
                    // withCredentials([
                    //   file(credentialsId: "${params.cluster1}", variable: 'KUBECONFIG1'),
                    //   file(credentialsId: "${params.cluster2}", variable: 'KUBECONFIG2')])
                    //   {

                        sh """
                        echo '"${params.mode}"'
                        echo '${params.CHOICE}'
                        echo "${params.cluster1}"
                        echo ${params.cluster2}
                        """

                  }
              }
          }
      }
  }
