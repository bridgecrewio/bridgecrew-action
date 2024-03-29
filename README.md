# DEPRECATED: This project is no longer supported and will be archived end of 2023. Please use [checkov-action](https://github.com/bridgecrewio/checkov-action) instead.

# Bridgecrew GitHub Action

## The Bridgecrew GitHub Action

Use the Bridgecrew GitHub Action to scan for infrastructure-as-code misconfigurations, 
vulnerabilities and license issues in open source packages and images, and CI/CD misconfigurations.
By signing up for a free Bridgecrew Community plan you can also view dashboards and reports.
The community plan does not limit the number of scans or users you can invite to view the results.

## How to use the Bridgecrew GitHub Action

1. Follow the instructions at [GitHub configuration a workflow](https://help.github.com/en/actions/configuring-and-managing-workflows/configuring-a-workflow) to enable Github Action in your repository.
2. Set up an environment variable with your Bridgecrew API key, which you can get from your [Bridgecrew account](https://www.bridgecrew.cloud/integrations).
3. In the app build job, uses the `bridgecrewio/bridgecrew-action@master`
4. Optionally, supply parameters to customize GitHub action behaviour

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
         external_checks_dirs: ./checkov
         download_external_modules: true # optional: download external terraform modules from public git repositories and terraform registry
         log_level: DEBUG # optional: set log level. Default WARNING
         use_enforcement_rules: true # optional - use enforcement rule configs from the platform

```

### Github code scanning

Bridgecrew supports github [code scanning](https://docs.github.com/en/free-pro-team@latest/github/finding-security-vulnerabilities-and-errors-in-your-code/about-code-scanning).
An example workflow configuration can be found [here](examples/code_scanning.yml).

## GitHub action Parameters

| Parameter                     | Description                                                                                                                                                  | Required | Default | Type                                    |
|-------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|---------|-----------------------------------------|
| api-key                       | Environment variable name of the Bridgecrew API key from Bridgecrew app                                                                                      | No       |         | Secret parameter                        |
| file                          | File to scan                                                                                                                                                 | No       |         | Input parameter                         |
| directory                     | Root directory to scan                                                                                                                                       | No       | "."     | Input parameter                         |
| soft_fail                     | Runs checks without failing build                                                                                                                            | No       |         | Input parameters                        |
| check                         | filter scan to run only on a specific check identifier, You can specify multiple checks separated by comma delimiter                                         | No       |         | Input parameters                        |
| skip_check                    | filter scan to run on all check but a specific check identifier(blacklist), You can specify multiple checks separated by comma delimiter, clashes with check | No       |         | Input parameters                        |
| quiet                         | display only failed checks                                                                                                                                   | No       |         | Input parameters                        |
| external_checks_dirs          | Directory for custom checks to be loaded                                                                                                                     | No       |         | Input parameters                        |
| output_format                 | The format of the output - json - cli - sarif                                                                                                                | No       |         | Input parameters                        |
| output_file_path              | The path for the file output                                                                                                                                 | No       |         | Input parameters                        |
| framework                     | run on a specific infrastructure                                                                                                                             | No       |         | cloudformation,terraform,kubernetes,all |
| download_external_modules     | download external terraform modules from public git repositories and terraform registry                                                                      | No       |         | Input parameters                        |
| repo_root_for_plan_enrichment | root directory containing the hcl templates used to generate the given terraform plan file. Use together with `file`                                         | No       |         | Input parameters                        |
| log_level                     | set log level                                                                                                                                                | No       | WARNING | Input parameters                        |

Full reference docs [here](https://docs.bridgecrew.io/docs/integrate-with-github-actions-v2).

## Screenshots

Reject pull requests containing infrastructure code configuration errors
![](resources/failed-action.png)
Find & fix resources that might be a risk
![](resources/problem-matcher.png)
