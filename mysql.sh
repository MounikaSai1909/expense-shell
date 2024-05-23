USERID=$(id -u)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOG_FILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
     echo -e "$2  $R  FAILURE $N "
    else 
     echo -e "$2  $G  SUCCESS $N "
    fi
}

if [ $USERID -ne 0 ]
then 
    echo " Please run with super user "
else 
    echo " You are a super user"
fi
#
#
#
dnf install mysql-server -y &>> $LOGFILE
VALIDATE $? "installing mysql server"

systemctl enable mysqld &>> $LOGFILE
VALIDATE $? "enabling mysqld service"

systemctl start mysqld &>> $LOGFILE
VALIDATE $? "staring mysql service"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>> $LOGFILE
VALIDATE $? "setting up the root password"