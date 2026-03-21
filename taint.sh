#!/bin/bash
for instance in $(terraform state list | grep -i 'google_compute_instance.tf-vm-instances'); do
   terraform taint $instance
done