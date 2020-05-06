# Bridgecrew GitHub Action

## The Bridgecrew GitHub Action

Use the Bridgecrew GitHub action to scan for infrastrcture-as-code errors in your GitHub action pipeline.
By utilizing this GitHub action in your project workflow, you can automatically start to find,
fix and monitor your project for configuration errors in Terraform and CloudFormation. 
By signing up for a free Bridgecrew Community plan you can also view dashboards and reports. 
The community plan does not limit the number of scans or users you can invite to view the results.
​
## How to use the Bridgecrew GitHub Action

In fact, it is very easy to start using the GitHub action.
All you need to do is:

1. Follow the instructions at [GitHub configuration a workflow](https://help.github.com/en/actions/configuring-and-managing-workflows/configuring-a-workflow) to enable Github Action in your repository. 
2. Set up an environment variable with your Bridgecrew API key, which you can get from your [Bridgecrew account](https://www.bridgecrew.cloud/integrations).
3. In the app build job, uses the `bridgecrewio/bridgecrew-action@master`
4. Optionally, supply parameters to customize GitHub action behaviour
## Usage Examples

### Scan IaC Directory

```yaml
  - name: Run Bridgecrew scanner
    id: Bridgecrew scanner
    uses: bridgecrewio/bridgecrew-action@master
    with:
      directory: "terraform"
      soft-fail: "true"
      output: "junitxml"
      api-key-variable: ${{ secrets.API_KEY }}
```

### Scan IaC Files

```yaml
  - name: Run Bridgecrew scanner
    id: Bridgecrew scanner
    uses: bridgecrewio/bridgecrew-action@master
    with:
        file: "./terraform/db-app.tf"
        output: "json"
        api-key-variable: ${{ secrets.API_KEY }}
```

## GitHub action Parameters

Full reference docs [TODO]

| Parameter  | Description | Required | Default | Type |
| -----------| -------------------------------------------------------------------------------------------------------- | ------------- | ------------- | ------------- |
| api-key-variable | Environment variable name of the Bridgecrew API key from Bridgecrew app | No |  | Secret parameter |
| directory | IaC root directory to scan | No | "none" | Input parameter |
| file | IaC file to scan | No | "none" | Input parameter |
| soft-fail | Runs checks without failing build | No | "false" | Input parameters |
| output | Report output format | No | "cli" | cli \ json \ junitxml |

## Screenshots
Run Bridgecrew GitHub in your GitHub pipeline
