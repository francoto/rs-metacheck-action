# RsMetaCheck GitHub Action

A GitHub Action to detect metadata pitfalls in software repositories using SoMEF.
This action wraps the [RsMetaCheck](https://pypi.org/project/rsmetacheck/) Python tool.

## Usage

Create a workflow file in your repository, for example `.github/workflows/rsmetacheck.yml`:

```yaml
name: RsMetaCheck Validation

on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  analyze-metadata:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Run RsMetaCheck
        uses: your-github-username/rsmetacheck-action@v1
        with:
          # You can pass the repository URL automatically
          input: "https://github.com/${{ github.repository }}"
          pitfalls_output: "./pitfalls_outputs"
          verbose: "false"
```

### Inputs

| Input               | Description                                                            | Required | Default                   |
| ------------------- | ---------------------------------------------------------------------- | -------- | ------------------------- |
| `input`             | One or more: GitHub/GitLab URLs, JSON files containing repositories.   | **Yes**  |                           |
| `skip_somef`        | Skip SoMEF execution and analyze existing SoMEF output files directly. | No       | `false`                   |
| `pitfalls_output`   | Directory to store pitfall JSON-LD files.                              | No       | `./pitfalls_outputs`      |
| `somef_output`      | Directory to store SoMEF output files.                                 | No       | `./somef_outputs`         |
| `analysis_output`   | File path for summary results.                                         | No       | `./analysis_results.json` |
| `threshold`         | SoMEF confidence threshold. Only used when running SoMEF.              | No       | `0.8`                     |
| `branch`            | Branch of the repository to analyze.                                   | No       |                           |
| `generate_codemeta` | Generate codemeta files for each repository.                           | No       | `false`                   |
| `verbose`           | Include both detected AND undetected pitfalls in the output JSON-LD.   | No       | `false`                   |
