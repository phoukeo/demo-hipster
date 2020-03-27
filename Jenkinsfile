properties([[$class: 'JiraProjectProperty'], gitLabConnection(''),
  parameters([
    choice(choices: ['apply', 'delete'], description: '', name: 'mode'),
    credentials(name: 'cluster1', credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl', defaultValue: 'user1-anthos-ansiblized-kubeconfig', description: '', required: true),
    credentials(name: 'cluster2', credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl', defaultValue: 'chicken-crossed-the-road-kubeconfig', description: '', required: true)
    ])])

podTemplate(
  cloud: 'kubernetes',
  containers: [
    containerTemplate(name: 'anthos', image: 'thilavanh/centos-kubectl', ttyEnabled: true,)]
)
{
  node(POD_LABEL) {
      stage('Prep for Hybrid Hipster Deployment') {
          container('anthos') {
              stage('Installing Hybrid Hipster Demo App') {
              git (url: 'https://github.com/phoukeo/demo-hipster.git', credentialsId: 'phoukeo-github')
              withCredentials([
                file(credentialsId: "${cluster1}", variable: 'KUBECONFIG1'),
                file(credentialsId: "${cluster2}", variable: 'KUBECONFIG2')])
              {
                sh """
                kubectl --kubeconfig $KUBECONFIG2 ${params.mode} -f ./hybrid/onprem -n hipster
                kubectl --kubeconfig $KUBECONFIG1 ${params.mode} -f ./hybrid/cloud -n hipster
                """
              }
            }
          }
      }
  }
}
