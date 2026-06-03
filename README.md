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
        uses: actions/checkout@v6

      - name: Run RsMetaCheck
        uses: SoftwareUnderstanding/rs-metacheck-action@0.3.1
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

### Outputs

| Output            | Description                                                          |
| ----------------- | -------------------------------------------------------------------- |
| `has_pitfalls`    | `'true'` if any pitfalls or warnings were detected                   |
| `total_pitfalls`  | Total number of pitfalls detected (P-codes)                          |
| `total_warnings`  | Total number of warnings detected (W-codes)                          |
| `pitfalls_found`  | JSON array of detected pitfall codes (e.g. `'["P001","P003"]'`)     |
| `warnings_found`  | JSON array of detected warning codes (e.g. `'["W001","W002"]'`)     |

### Visual Output

This action automatically reports results in the GitHub Actions UI:

1. **Step Summary** — A rendered Markdown table appears at the bottom of the workflow run page, showing all detected pitfalls and warnings with descriptions, counts, and per-repository details.

2. **Annotations** — Detected pitfalls appear as `::error::` annotations (red markers) and warnings as `::warning::` annotations (yellow markers) at the top of the workflow run page. When triggered by a pull request, these also appear inline on the diff view.

3. **Exit status** — If any pitfalls or warnings are found, the action exits with code 1, causing the step to show as failed (red) in the workflow UI.

4. **JSON-LD reports** — Per-repository JSON-LD files remain on disk in the `pitfalls_output` directory. Add `actions/upload-artifact@v4` to your workflow to make them downloadable as build artifacts.
