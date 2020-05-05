# Bridgecrew GitHub Action

## The Bridgecrew GitHub Action

Use the Bridgecrew GitHub action to scan for infrastrcture-as-code errors in your GitHub action pipeline.
By utilizing this GitHub action in your project workflow, you can automatically start to find,
fix and monitor your project for configuration errors in Terraform and CloudFormation. 
By signing up for a free Bridgecrew Community plan you can also view dashboards and reports. 
The community plan does not limit the number of scans or users you can invite to view the results.
​
## How to use the Bridgecrew Orb

In fact, it is very easy to start using the GitHub action.
All you need to do is:

1. Follow the instructions at the [TODO]
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
      DIRECTORY: 'terraform'
      SOFT-FAIL: 'true'
      OUTPUT: "junitxml"
```

### Scan IaC Files

```yaml
  - name: Run Bridgecrew scanner
    id: Bridgecrew scanner
    uses: bridgecrewio/bridgecrew-action@master
    with:
        FILE: "./terraform/db-app.tf"
        OUTPUT: "json"
        API-KEY-VARIABLE: "BC_API_KEY"
```

### Advanced Example

```yaml

```

## GitHub action Parameters

Full reference docs [TODO]

| Parameter  | Description | Required | Default | Type |
| -----------| -------------------------------------------------------------------------------------------------------- | ------------- | ------------- | ------------- |
| api-key-variable | Environment variable name of the Bridgecrew API key from Bridgecrew app | no | BC_API_KEY | env_var_name |
| directory | IaC root directory to scan | no | "none" | string |
| file | IaC file to scan | no | "none" | string |
| soft-fail | Runs checks without failing build | no | false | boolean |
| output | Report output format | no | "cli" | cli \ json \ junitxml |

## Screenshots
Run Bridgecrew GitHub in your GitHub pipeline
