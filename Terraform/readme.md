#Got stuck on outputs. Why? When dreating outputs.tf i was confused on whether i'd need two blocks for IAMROLE due to it havintg two ARNS from two policies, but i realised when i make the IAMROLE that creates its own unique ARN - different from policies and thats what it's outputs is displaying, not the actual ARN of the 2 policies, hence why even if i add 10 policies, the ARN will still be 1 unique one for the role as thats what it denotes.

#2. Coudlnt run terraform init but had to troubleshoot and use get-location , dir*.tf,  cd terraform , terraform init.

#3. forgout about this - anyway figure out default in relation to terra.tfvars or whatever that we arent including in our variables.tf (still functions) and if tags for iam policy is rlly needed.

#4. As complexity has grown with phase 2 and variables with Glue Crawler - We must add terraform.tfvars which we forgot earlier LOOOOOOOOL. its ok. apart of the learning process!. 

#5. Had to go back and add depends me on athena DB creation for its bucket. 

#6. A bunch of fixes in path location for glue crawler and its bucket.

