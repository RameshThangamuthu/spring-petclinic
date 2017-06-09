status="Started"
aws cloudformation create-stack --stack-name myec2 --template-body file://EC2.json --parameters ParameterKey=KeyName,ParameterValue=Ramesh_Personal ParameterKey=InstanceType,ParameterValue=t1.micro ParameterKey=SSHLocation,ParameterValue=0.0.0.0/0

while [ "$status" != "CREATE_COMPLETE" ] && [ "$status" != "ROLLBACK_COMPLETE" ]
do
  status=$(aws cloudformation describe-stacks --stack-name myec2|python -c "import sys, json; print json.load(sys.stdin)['Stacks'][0]['StackStatus']")
  echo "Current Status: $status"
  sleep 10
done

if [ "$status" == "CREATE_COMPLETE" ]; then
 echo $(aws cloudformation describe-stacks --stack-name myec2|python -c "import sys, json; print json.load(sys.stdin)['Stacks'][0]['Outputs'][0]['OutputValue']")
 #outputs=$(aws cloudformation describe-stacks --stack-name myec2|python -c "import sys, json; print json.load(sys.stdin)['Stacks'][0]['Outputs']")
 #echo "$outputs"
 #python -c "import sys, json; outx=[x for x in json.load($outputs) if x['OutputKey'] == 'PublicIP']" 
 #publicIP=$([x for x in outputs if x['OutputKey'] == 'PublicIP'])
 #echo "$publicIP"
 #echo publicIP['OutputValue']")
else
 echo "The Stack creation Failed"
fi