<?php
require_once "config.php"
require_once "session.php"

if($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['submit'])){
    $name = trim($_POST['name']);
    $username = trim($_POST['username']);
    $password = trim($_POST['password']);
    $password_hash = password_hash($password, PASSWORD_BCRYPT)
    $confirmpassword = trim($_POST['confirmpassword']);
    $email = trim($_POST['email']);
    $dob = trim($_POST['dob']);

    if($query = $db_zoldygan->prepare("SELECT * FROM USER where username = ?")){
        $error = '';
        $query->bind_param('s', $username);
        $query->execute();
        $query->store_result();

        if($query->num_rows > 0){
            $error .= '<p class="error">The email is already registered!</p>';
        }else{
            if(strlen($password) < 6){
                $error .='<p class="error">Password must have altleast 6 Character.</p>';
            }

            if($password != $confirmpassword){
                $error .= '<p class="error">Password did not match.</p>';
            }
        }

        if(empty($error)){
            $insertQuery = $db_zoldygan->prepare("INSERT INTO USER() VALUES()");
            $insertQuery->bind_param("sssss", $name, $username, $password, $email, $dob);
            $result = $insertQuery->execute();
            if($result) {
                $error .= '<p class="success">Your Registration was successfull!</p>';
            }else{
                $error .= '<p class="error">Something Went wrong!</p>';
            }
        }
    }
    $query->close();
    $insertQuery->close();
    mysqli_close($db_zoldygan);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <title>Register</title>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1><strong>Register</strong></h1>
                <p>Please fill this form to create an account.</p>
                <form action="" method="post">
                    <div class="form-group row">
                        <div class="col-md-8">
                            <label for="Name">Name</label>
                            <input type="text" name="name" class="form-control" required>
                        </div>
                        <div class="col-md-4">
                            <label for="nickname">Nickname</label>
                            <input type="text" name="nickname" class="form-control">
                        </div>    
                    </div>
                    <div class="form-group row">
                        <div class="col-md-6">
                            <label for="username">Username</label>
                            <input type="text" name="username" class="form-control" required>
                        </div>
                        <div class="col-md-3">
                            <label for="dob">Date of Birth</label>
                            <input type="date" name="dob" class="form-control" required>
                        </div>
                        <div class="col-md-3">
                            <label for="gender">Gender</label>
                            <input type="text" name="gender" class="form-control">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-6">
                            <label for="email">Email</label>
                            <input type="email" name="email" class="form-control">
                        </div>
                        <div class="col-md-6">
                            <label for="phone">Phone</label>
                            <input type="text" name="phone" class="form-control">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-md-6">
                            <label for="password">Password</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label for="confirmpassword">Confirm Password</label>
                            <input type="password" name="confirmpassword" class="form-control" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" name="address" class="form-control">
                    </div>
                    <br>
                    <div class="form-group">
                        <input type="submit" name="submit" class="btn btn-primary" value="Register">
                        <input type="reset" name="reset" class="btn btn-warning" value="Reset">
                    </div>
                    <p>Already have an account? <a href="/login">Login Here</a>.</p>
                </form>
            </div>
        </div>
    </div>
</body>
</html>