# KEDA Demo for Rancher Desktop

This repository contains a complete KEDA (Kubernetes Event-Driven Autoscaling) demonstration that showcases auto-scaling from 0 to N pods based on RabbitMQ queue length.

## Quick Start

```bash
# Run the demo with default settings (15 messages, expect 3 pods)
./keda-demo start

# Run with custom configuration and monitoring
./keda-demo start --messages 20 --processing-time 1 --cooldown 5 --watch

# Fast preset (10 messages, 1s processing, 5s cooldown)
./keda-demo start --fast

# 🤖 Fully automated demo - runs and exits automatically when complete
./keda-demo start --fast --auto-close

# Clean up everything
./keda-demo clean

# Just start the log watcher
./keda-demo watch
```

## Features

- 🚀 **One-command setup**: Installs KEDA, deploys RabbitMQ, and configures auto-scaling
- ⚙️ **Configurable timing**: Adjust messages, processing time, cooldown periods via CLI
- 📊 **Progress bars**: Clear visual feedback during setup and message sending
- 🔍 **Enhanced monitoring**: Real-time log watcher with pod status, queue metrics, and KEDA insights
- 🤖 **Auto-close**: Fully automated demos that exit when scaling completes
- 📁 **Modular architecture**: Separate Python consumer app and Kubernetes manifests
- 🐳 **Container-based**: Consumer app packaged as proper Docker image
- 🎯 **Presets**: Fast and slow demo configurations for different scenarios
- 🔄 **GitHub Actions CI/CD**: Automated testing and demo execution in GitHub workflows

## How It Works

1. **Deploy RabbitMQ** with queue `demo-queue`
2. **Deploy consumer** that processes messages with configurable delay
3. **Create KEDA ScaledObject** that monitors queue length
4. **Send messages** to trigger auto-scaling
5. **Watch scaling** from 0 → N pods → 0 as queue empties

## Configuration Options

| Option | Default | Description |
|--------|---------|-------------|
| `--messages N` | 15 | Number of messages to send |
| `--per-pod N` | 5 | Messages per pod threshold |
| `--processing-time N` | 2 | Processing time per message (seconds) |
| `--polling N` | 2 | KEDA polling interval (seconds) |
| `--cooldown N` | 10 | KEDA cooldown period (seconds) |
| `--max-replicas N` | 10 | Maximum number of replicas |
| `--watch` | false | Auto-start log watcher |
| `--auto-close` | false | Auto-exit when demo completes (requires --watch) |

## Project Structure

```
keda-demo/
├── keda-demo              # Main demo script
├── log-watcher            # Enhanced monitoring script
├── manifests/             # Kubernetes manifests
│   ├── rabbitmq.yaml     # RabbitMQ deployment & service
│   ├── consumer.yaml     # Message consumer deployment
│   └── scaledobject.yaml # KEDA ScaledObject template
├── common/                # Shared utilities
│   ├── logger.sh          # Colored logging functions
│   └── test-logger.sh     # Logger test script
└── README.md              # This file
```

## Consumer Application

The consumer application (`consumer.py`) is a standalone Python application that:

- Connects to RabbitMQ with retry logic and proper error handling
- Processes messages from the `demo-queue` with configurable processing time
- Supports graceful shutdown on SIGINT/SIGTERM signals
- Includes comprehensive logging and health checks
- Is embedded as a Docker container for consistent deployment

## GitHub Actions Workflow

This repository includes a GitHub Actions workflow (`.github/workflows/keda-demo.yml`) that automatically tests the KEDA demo in a CI/CD environment.

### Workflow Features

- 🔄 **Automated Testing**: Runs on every push to main/develop branches and pull requests
- 🎛️ **Manual Execution**: Supports workflow_dispatch with customizable parameters
- ☸️ **Complete K8s Setup**: Creates a kind (Kubernetes in Docker) cluster with multiple nodes
- 📦 **Full Demo Stack**: Installs KEDA, runs the complete demo, and verifies results
- 🧹 **Automatic Cleanup**: Ensures all resources are cleaned up after each run
- 📊 **Comprehensive Logging**: Collects diagnostic information on failures

### Manual Workflow Execution

You can manually trigger the workflow from GitHub's Actions tab with custom parameters:

- **Messages**: Number of messages to send (default: 10)
- **Processing Time**: Time per message in seconds (default: 2)
- **Cooldown**: KEDA cooldown period in seconds (default: 10)
- **Max Replicas**: Maximum number of consumer pods (default: 5)

### Workflow Steps

1. **Environment Setup**: Installs kubectl, Helm, and kind
2. **Cluster Creation**: Sets up a 3-node Kubernetes cluster using kind
3. **KEDA Installation**: Installs KEDA via Helm charts
4. **Demo Execution**: Runs the KEDA demo with specified parameters
5. **Verification**: Checks that autoscaling occurred and pods scaled down to zero
6. **Cleanup**: Removes all demo resources and deletes the cluster

### CI/CD Integration

The workflow is ideal for:
- Testing KEDA configuration changes
- Validating manifest updates
- Ensuring demo functionality across code changes
- Demonstrating KEDA capabilities in a reproducible environment

---

## Comparison: KEDA vs Other Autoscaling & Event-Driven Tools

This section compares **KEDA** with other open-source and managed autoscaling/event-driven systems that handle scale-to-zero or event-based workloads.
Focus: cost efficiency, maintainability, and production readiness for EKS/Fargate setups.

---

## Comparison Table

| Tool / Service              | Type              | Scale to Zero | Cloud-Agnostic | Complexity | Cost Model                  | Pros                                                                 | Cons                                                                 |
|-----------------------------|------------------|----------------|----------------|-------------|-----------------------------|----------------------------------------------------------------------|----------------------------------------------------------------------|
| **KEDA**                    | Open Source       | ✅ Yes          | ✅ Yes          | ⚙️ Medium    | Free (infra only)           | - Native Kubernetes integration<br>- Supports 60+ event sources<br>- Works with any cluster<br>- IRSA-ready on EKS | - Needs Cluster Autoscaler/Fargate<br>- Cold starts<br>- Extra CRDs to manage |
| **Knative Serving**         | Open Source       | ✅ Yes          | ✅ Yes          | ⚙️ High      | Free (infra only)           | - Built-in HTTP autoscaling<br>- Developer-friendly function model<br>- Scale to zero with revisions | - Heavy resource footprint<br>- Complex networking (Istio/Contour)<br>- Harder multi-cloud ops |
| **Kubeless**                | Open Source       | ⚠️ Partial      | ✅ Yes          | ⚙️ Low       | Free (infra only)           | - Simple function deployment<br>- Small footprint | - Unmaintained<br>- Limited event sources<br>- No real autoscaling integration |
| **OpenFaaS**                | Open Source       | ✅ Yes          | ✅ Yes          | ⚙️ Medium    | Free (infra only)           | - Function-based deployment model<br>- Good UI and metrics<br>- Supports Prometheus-based autoscaling | - Custom API Gateway required<br>- Additional ops maintenance |
| **Fission**                 | Open Source       | ✅ Yes          | ✅ Yes          | ⚙️ Medium    | Free (infra only)           | - Fast cold starts via poolmgr<br>- Scale to zero<br>- HTTP + message triggers | - Moderate overhead<br>- Smaller community<br>- Needs separate controller pods |
| **AWS Lambda**              | Managed Service   | ✅ Yes          | ❌ AWS Only     | ⚙️ Low       | Pay-per-request + compute   | - No cluster ops<br>- Built-in scaling<br>- Fully managed<br>- Integrated with AWS events | - Vendor lock-in<br>- Harder local debugging<br>- Pricey for high-load workloads |
| **Azure Functions**         | Managed Service   | ✅ Yes          | ❌ Azure Only   | ⚙️ Low       | Pay-per-request + compute   | - Fully managed<br>- Easy event integration<br>- Auto scale to zero | - Vendor lock-in<br>- Cold starts<br>- Limited runtime customization |
| **Google Cloud Functions**  | Managed Service   | ✅ Yes          | ❌ GCP Only     | ⚙️ Low       | Pay-per-request + compute   | - Simple deploy<br>- Automatic scaling<br>- Fully managed | - Vendor lock-in<br>- Higher latency cold starts<br>- Costly for bursty loads |

---

## Summary

| Scenario | Recommended Tool | Reason |
|-----------|------------------|--------|
| **EKS/Fargate cost optimization** | **KEDA** | Native, free, integrates with IRSA, minimal runtime cost |
| **Kubernetes HTTP-based functions** | **Knative** | Mature HTTP scale-to-zero support |
| **Simpler event-driven workloads** | **OpenFaaS** | Good middle ground, easy UI |
| **Fully managed, no ops** | **AWS Lambda** | Perfect for AWS-only and minimal maintenance |
| **Cross-cloud FaaS strategy** | **KEDA + Fargate or OpenFaaS** | Vendor-neutral, cheaper long term |

---

## Key Takeaways

- **KEDA + Fargate** = optimal for hybrid cost-saving inside EKS.
- **Lambda** = best for fully serverless, but higher cost and AWS lock-in.
- Open-source solutions trade off simplicity for flexibility and cost control.
