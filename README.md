# Bridgecrew GitHub Action

## The Bridgecrew GitHub Action

Use the Bridgecrew GitHub action to scan for infrastructure-as-code errors in your GitHub action pipeline.
By utilizing this GitHub action in your project workflow, you can automatically start to find,
fix and monitor your project for configuration errors in Terraform, CloudFormation, and Kubernetes. 
By signing up for a free Bridgecrew Community plan you can also view dashboards and reports. 
The community plan does not limit the number of scans or users you can invite to view the results.
​
## How to use the Bridgecrew GitHub Action

In fact, it is very easy to start using the GitHub action.
All you need to do is:

1. Follow the instructions at [GitHub configuration a workflow](https://help.github.com/en/actions/configuring-and-managing-workflows/configuring-a-workflow) to enable Github Action in your repository.
2. Set up an environment variable with your Bridgecrew API key, which you can get from your [Bridgecrew account](https://www.bridgecrew.cloud/integrations).
3. In the app build job, uses the `bridgecrewio/bridgecrew-action@master`
4. Optionally, supply parameters to customize GitHub action behavior

## Usage Examples

### Scan IaC in your repository

```yaml
      - name: Run Bridgecrew 
        id: Bridgecrew
        uses: bridgecrewio/bridgecrew-action@master
        with:
         api-key: ${{ secrets.BRIDGECREW_API_KEY }}
         directory: "example/examplea"
         check: CKV_AWS_1 # optional: run only a specific check_id. can be comma separated list
         skip_check: CKV_AWS_1 # optional: skip a specific check_id. can be comma separated list
         soft_fail: false
         framework: terraform # optional: run only on a specific infrastructure {cloudformation,terraform,kubernetes,all}
         output_format: cli
         quiet: false
         external_checks_dir: ./checkov
         download_external_modules: true # optional: download external terraform modules from public git repositories and terraform registry
         log_level: DEBUG # optional: set log level. Default WARNING

```

### Github code scanning

Bridgecrew supports GitHub [code scanning](https://docs.github.com/en/free-pro-team@latest/github/finding-security-vulnerabilities-and-errors-in-your-code/about-code-scanning).
An example workflow configuration can be found [here](examples/code_scanning.yml).

## GitHub action Parameters

| Parameter  | Description | Required | Default | Type |
| -----------| -------------------------------------------------------------------------------------------------------- | ------------- | ------------- | ------------- |
| api-key | Environment variable name of the Bridgecrew API key from Bridgecrew app | No |  | Secret parameter |
| directory | IaC root directory to scan | No | "." | Input parameter |
| soft_fail | Runs checks without failing build | No | | Input parameters |
| check | filter scan to run only on a specific check identifier, You can specify multiple checks separated by comma delimiter | No |  | Input parameters |
| skip_check | filter scan to run on all check but a specific check identifier(blacklist), You can specify multiple checks separated by comma delimiter, clashes with check | No |  | Input parameters |
| quiet | display only failed checks | No |  | Input parameters |
| external_checks_dir | Directory for custom checks to be loaded | No |  | Input parameters |
| output_format| The format of the output - json - cli - sarif | No |  | Input parameters |
| framework | run on a specific infrastructure | No | | Cloudformation,Terraform,Kubernetes,all |
| download_external_modules | download external terraform modules from public git repositories and terraform registry | No | |Input parameters |
| log_level | set log level | No | WARNING | Input parameters |

Full reference docs [here](https://docs.bridgecrew.io/docs/integrate-with-github-actions-v2).

## Screenshots

Reject pull requests containing infrastructure code configuration errors
![](resources/failed-action.png)
Find & fix resources that might be a risk
![](resources/problem-matcher.png)
