# devops-interview

## Part 1 - Terraform Task

### Write a terraform script that creates resources in Google Cloud which includes:

* A VPC with subnets
* Firewall rules for the VPC to allow SSH
* A public Cloud DNS zone with your specified subdomain (Adding NS records to parent domain can be manual)
* Managed Google Cloud Certificate for your `api.${subdomain}` (Google doesn't allow wildcard managed cert)
* A GCE instance (VM) under one of the created subnets (Debian or Ubuntu) with proper startup script
* A HTTPS load balancer for the GCE instance that connects to the instance's TCP port 3000 with the created google cloud certificate

Implement each of vpc, dns, instance and cert as a terraform module

The modules are then invoked by a `main.tf` file in the root of the directory

The instance startup script should prepare the machine with the some packages such as python and ansible

### Infra Code

The infra code already contains a set of terraform code for use with AWS. You can use this for reference

Your implementation should work in a similar way

## Part 2 - Integrate with Ros CLI

Ultimately this code will be integrated with an open source tool for managing a micro service project
which includes standing up the infrastructure that the TF code from Part 1 implements

### Setup the environment

The Ros project has a full development environment using a VirtualBox (vagrant) virtual machine

The setup assumes running VirtualBox and vagrant on MacOS with instructions [here](https://github.com/rails-on-services/setup)

To setup VirtualBox on Windows see ?

To setup Vagrant on Windows see [this](https://www.vagrantup.com/docs/installation)

If you can complete [this section](https://github.com/rails-on-services/setup#verify-vm-configuration)
then everything is setup ok

### Integrate TF code into Ros CLI

**All commands are executed in the VM**

```bash
vagrant ssh
cd [project-name]
git clone https://github.com/rails-on-services/ros project
```

cd to `ros/cli` where there is a ruby project for the cli. The source repo is [here](https://github.com/rails-on-services/ros-cli)

Steps:

* Copy your TF modules to `lib/ros/generators/be/infra/files/terraform/gcp`
* Copy your main.tf to `lib/ros/generators/be/infra/templates/terraform/gcp/instance.tf.erb` This will become a ruby ERB template

Run the cli in ~/[project-name]/project (the code that was cloned earlier)

```bash
cd ~/[project-name]/project
ros generate:be:infra
```

You should see code generated in `tmp/deployments/development/be/infra`. This code will be AWS specific

* Update the project cofiguration in `config/deployments/development.yml` replacing AWS components with GCP components
* run `ros generate:be:infra` which should now generate TF modules for GCP
* once the modules copy is working you will update the instance.tf.erb to take values from the `config/deployments/development.yml` file
* you will need to update some ruby code in lib/ros/generators/be/infra/infra_generator.rb to convert generic names like `dns` to the GCP equivalent

This is not a trivial piece of work, but is representative of the type of work you would be doing.
If you enjoy this you will enjoy your job here.

## Part 3 - Bonus

Clone the [setup repo](https://github.com/rails-on-services/setup), update the README.md for installing and
setting up on Windows and submit a Pull Request
