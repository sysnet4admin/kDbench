echo ===================
echo "1.Container build"
echo ===================
if [[ "$#" -eq 0 ]]; then
  docker build -t sysnet4admin/kdbench:latest .
elif [[ -z $1 ]]; then 
  docker build -t sysnet4admin/kdbench:$1 -t sysnet4admin/kdbench:latest .
else 
  echo "No Support. check $#"
fi 
echo ==============================
echo "2.docker push to sysnet4admin"
echo ==============================
docker push sysnet4admin/kdbench --all-tags
