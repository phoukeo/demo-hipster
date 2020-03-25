// properties([[$class: 'JiraProjectProperty'], gitLabConnection(''),
//   parameters([
//     choice(choices: ['apply'], description: '', name: 'mode'),
//     credentials(name: 'cluster1', credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl', defaultValue: 'user1-anthos-ansiblized-kubeconfig', description: '', required: true),
//     credentials(name: 'cluster2', credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl', defaultValue: 'chicken-crossed-the-road-kubeconfig', description: '', required: true)
//     ])])

podTemplate(
  cloud: 'kubernetes',
  containers: [
    containerTemplate(name: 'anthos', image: 'thilavanh/centos-kubectl', ttyEnabled: true,)]
)
{
  node(POD_LABEL) {
    parameters {
      choice choices: ['apply', 'delete'], description: 'apply or delete app deployment', name: 'mode'
      credentials credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl', defaultValue: 'user1-anthos-ansiblized-kubeconfig', description: 'Kubeconfig file for Cluster1', name: 'cluster1', required: true
      credentials credentialType: 'org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl', defaultValue: 'chicken-crossed-the-road-kubeconfig', description: 'Kubeconfig file for Cluster2', name: 'cluster2', required: true
    }
      stage('Get an Anthos project') {
          container('anthos') {
              stage('Install Hybrid Hipster Demo Application')
              {
                sh """
                kubectl --kubeconfig ${params.cluster2} ${params.mode} -f ./hybrid/onprem -n hipster
                kubectl --kubeconfig ${params.cluster1} ${params.mode} -f ./hybrid/cloud -n hipster
                """
              }
          }
      }
  }
}
