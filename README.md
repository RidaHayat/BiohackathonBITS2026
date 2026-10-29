# BioHackathon BITS 2026: Biological Network Inference

[![R](https://img.shields.io/badge/R-%3E%3D4.0-blue.svg)](https://www.r-project.org/)
[![BITS](https://img.shields.io/badge/BITS-Bioinformatics_Italian_Society-green.svg)](https://bioinformatics.it/)
[![Award: Winner](https://img.shields.io/badge/Award-Overall_Winning_Team-gold.svg)](#awards--recognition)
[![Award: Honorable Mention](https://img.shields.io/badge/Honorable_Mention-GRN_Inference-orange.svg)](#awards--recognition)

Code and workflows developed by the overall winning team at the **2nd International BioHackathon** organized by the **Bioinformatics Italian Society (BITS)** (Padova, Italy — May 26–27, 2026).

---

## 🏆 Awards & Recognition

- **Overall Winning Team** — 2nd International BioHackathon (BITS 2026)
- **Honorable Mention** — Reverse Engineering of Gene Regulatory Networks challenge

**Team Members:**
- **Rida Hayat**
- **Alessandro Leone**
- **Margherita Morocutti**
- **Dhyani Solanki**

Official award document: [WinningTeam.pdf](WinningTeam.pdf)

---

## 🔬 Challenge Overview

The hackathon focused on reverse engineering biological networks from high-throughput omics data across two independent tracks, each evaluated on 10 benchmark datasets with ground truth followed by blind validation datasets.

```text
Biological Data ──┬──► Task 1: Metagenomics  ──► Compositional transforms (CLR/TSS) ──► Bacterial Co-occurrence Network
                  │
                  └──► Task 2: Transcriptomics ──► Random Forest regression (GENIE3) ──► Gene Regulatory Network (GRN)
```

---

## 🛠️ Tasks & Pipelines

### Task 1: Bacterial Interaction Networks (`Metagenome.Rmd`)
- **Challenge:** Metagenomic taxonomic count tables are high-dimensional, zero-inflated, and strictly compositional (constrained simplex). Direct Pearson correlation on raw counts introduces severe spurious associations.
- **Workflow:**
  1. **Filtering & Preprocessing:** Low-abundance filtering and minimal positive offset zero-imputation.
  2. **Compositional Transformations:** Total Sum Scaling (TSS) and Centered Log-Ratio (CLR) transformations to break compositional dependencies.
  3. **Network Inference:** Ridge-regularized precision matrix estimation (graphical Gaussian modeling) and rank correlation across taxa.
  4. **Evaluation:** Threshold scanning against gold-standard adjacency matrices using AUROC and precision-recall metrics.

### Task 2: Gene Regulatory Networks (`Transcriptomics.Rmd`) — *Honorable Mention*
- **Challenge:** Reconstructing directed transcriptional regulatory networks from gene expression matrices with simulated knockouts, knockdowns, and multifactorial perturbations.
- **Workflow:**
  1. **Model:** Implemented **GENIE3** (GEne Network Inference with Ensemble of trees). For each target gene, a Random Forest regressor predicts its expression profile using all remaining genes as candidate regulators.
  2. **Confidence Scores:** Variable importance measures from the ensemble trees serve as directed edge weights.
  3. **Threshold Optimization:** Scanned thresholds across 10 benchmark datasets, identifying **0.035** as the optimal cutoff balancing precision, recall, and F1 score.
  4. **Blind Prediction:** Applied the calibrated model to generate binary adjacency matrices for the 3 blind validation datasets.

---

## 📂 Repository Structure

```text
BiohackathonBITS2026/
├── README.md                          # Project documentation and summary
├── WinningTeam.pdf                    # Official winning team certificate
├── BioHackathon_2026_Instruction.pdf  # Competition instructions and task rules
├── Transcriptomics.Rmd                # Task 2 solution (GENIE3 GRN pipeline)
├── Metagenome.Rmd                     # Task 1 solution (Compositional network pipeline)
├── Trascriptomics_Dataset/            # Task 2 expression & gold-standard matrices
│   ├── Dataset1/ ... Dataset10/
│   └── validation/
└── MetaGenomics_Dataset/              # Task 1 taxonomic counts & adjacency matrices
    ├── dataset_1/ ... dataset_10/
    └── validation/
```

---

## 🚀 How to Run

Both pipelines are self-contained R Markdown notebooks.

### Prerequisites
Make sure R (>= 4.0) is installed. Required libraries:
```R
# Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("GENIE3")

# CRAN packages
install.packages(c("data.table", "ggplot2", "pheatmap", "PRROC", "reshape2", "dplyr"))
```

### Execution
Open and knit the notebooks in RStudio, or render from terminal:
```bash
# Task 1: Metagenomics pipeline
Rscript -e "rmarkdown::render('Metagenome.Rmd')"

# Task 2: Transcriptomics (GRN) pipeline
Rscript -e "rmarkdown::render('Transcriptomics.Rmd')"
```

---

## 📄 Reference
- **Organizers:** Giacomo Baruzzo, Giulia Cesaro, Matteo Pallocca (Bioinformatics Italian Society - BITS)
- **Event:** [BITS 2026 Hackathon](https://bioinformatics.it/)
