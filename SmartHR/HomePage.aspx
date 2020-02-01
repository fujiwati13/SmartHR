<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HomePage.aspx.vb" Inherits="SmartHR.HomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SMART HR</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

    <!-- Plugin CSS -->
    <link href="vendor/magnific-popup/magnific-popup.css" rel="stylesheet" type="text/css">

    <!-- Custom styles for this template -->
    <link href="css/freelancer.min.css" rel="stylesheet">
</head>

<body id="page-top">
    <form id="form1" runat="server">
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg bg-secondary fixed-top text-uppercase" id="mainNav">
            <div class="container">
                <a class="navbar-brand js-scroll-trigger" href="#page-top">SMART HR</a>
                <button class="navbar-toggler navbar-toggler-right text-uppercase bg-primary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
         
                    <i class="fa fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item mx-0 mx-lg-1">
                            <a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="login/login.aspx"><asp:Label runat="server" ID="lblLoginLogout"></asp:Label></a>
                        </li>
                         <li class="nav-item mx-0 mx-lg-1">
                            <a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="LiveChat/LiveChat.aspx"><asp:Label runat="server" ID="Label1" Text="Live Chat"></asp:Label></a>
                        </li>
                    </ul>
                   <%-- <ul class="navbar-nav ml-auto">
                        <li class="nav-item mx-0 mx-lg-1">
                            <a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#About"><asp:Label runat="server" ID="Label1" Text="About Us"></asp:Label></a>
                        </li>
                    </ul>--%>
                </div>
            </div>
        </nav>

        <!-- Header -->
        <header class="masthead bg-primary text-white text-center">
            <div class="container">
                <img class="img-fluid mb-5 d-block mx-auto" src="img/logo2.png">
                <%--<h1 class="text-uppercase mb-0">SMART HR</h1>--%>
                <hr class="star-light">
                <h2 class="font-weight-light mb-0">Request Document - Leave - Reimburse - Overtime</h2>
            </div>
        </header>

        <!-- Portfolio Grid Section -->
        <section class="portfolio" id="portfolio">
            <div class="container">
                <h2 class="text-center text-uppercase text-secondary mb-0">QUICK ACCESS</h2>
                <hr class="star-dark mb-5">
                <div class="row">
                    <div class="col-md-6 col-lg-4">
                        <a class="portfolio-item d-block mx-auto" href="#portfolio-modal-1">
                            <div class="portfolio-item-caption d-flex position-absolute h-100 w-100">
                                <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
                                    <i></i>
                                </div>
                            </div>
                            <a href="Document/HomeDoc.aspx">
                                <center><img class="img-fluid" src="img/Document.png" alt="Document/HomeDoc.aspx"></center>
                            </a>
                        </a>
                    </div>
                    <div class="col-md-6 col-lg-4">
                        <a class="portfolio-item d-block mx-auto" href="#portfolio-modal-2">
                            <div class="portfolio-item-caption d-flex position-absolute h-100 w-100">
                                <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
                                    <i></i>
                                </div>
                            </div>
                            <a href="Leave/HomeLeave.aspx">
                                <center><img class="img-fluid" src="img/Cuti.png" alt=""></center>
                            </a>
                        </a>
                    </div>
                    <div class="col-md-6 col-lg-4">
                        <a class="portfolio-item d-block mx-auto" href="#portfolio-modal-3">
                            <div class="portfolio-item-caption d-flex position-absolute h-100 w-100">
                                <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
                                    <i></i>
                                </div>
                            </div>
                            <a href="Overtime/HomeOvertime.aspx">
                                <img class="img-fluid" src="img/overtime.png" alt=""></a>
                        </a>
                    </div>
                    <div class="col-md-6 col-lg-4">
                        <a class="portfolio-item d-block mx-auto" href="#portfolio-modal-4">
                            <div class="portfolio-item-caption d-flex position-absolute h-100 w-100">
                                <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
                                    <i></i>
                                </div>
                            </div>
                            <a href="Reimburse/HomeReimburse.aspx">
                                <img class="img-fluid" src="img/Reimburse.png" alt=""></a>
                        </a>
                    </div>
                    <div class="col-md-6 col-lg-4">
                        <a class="portfolio-item d-block mx-auto" href="#portfolio-modal-5">
                            <div class="portfolio-item-caption d-flex position-absolute h-100 w-100">
                                <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
                                    <i></i>
                                </div>
                            </div>
                            <a href="Report/HomeReport.aspx">
                                <center><img class="img-fluid" src="img/Report.png" alt=""></center>
                            </a>
                        </a>
                    </div>
                    <div class="col-md-6 col-lg-4">
                        <a class="portfolio-item d-block mx-auto" href="#portfolio-modal-6">
                            <div class="portfolio-item-caption d-flex position-absolute h-100 w-100">
                                <div class="portfolio-item-caption-content my-auto w-100 text-center text-white">
                                    <i></i>
                                </div>
                            </div>
                            <a href="#about">
                                <center><img class="img-fluid" src="img/info.png" alt=""></center>
                            </a>
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- About Section -->
        <section class="bg-primary text-white mb-0" id="about">
            <div class="container">
                <h2 class="text-center text-uppercase text-white">About</h2>
                <hr class="star-light mb-5">
                <div class="row">
                    <div class="col-lg-4 ml-auto">
                        <p class="lead">SMART HR</p>
                        <p class="lead">"Improve The Way You Manage People"</p>
                    </div>
                    <div class="col-lg-4 mr-auto">
                        <p class="lead">
                            1. pengajuan cuti dan pengajuan raimbursment lembur, medical, transport dll 
                                juga lebih mudah dan dapat dilakukan dimanapun dan 
                                kapanpun
                        </p>
                        <p class="lead">2. pengajuan untuk request dokumen ( surat keterangan kerja, perjalanan dinas dll ) juga lebih mudah dan efisien serta dapat dilakukan dimanapun dan kapanpun</p>
                    </div>
                </div>

            </div>
        </section>


        <!-- Footer -->
        <footer class="footer text-center">
            <div class="container">
            </div>
        </footer>

        <div class="copyright py-4 text-center text-white">
            <div class="container">
                <small>Copyright &copy; SMART HR 2018</small>
            </div>
        </div>

        <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
        <div class="scroll-to-top d-lg-none position-fixed ">
            <a class="js-scroll-trigger d-block text-center text-white rounded" href="#page-top">
                <i class="fa fa-chevron-up"></i>
            </a>
        </div>


        <!-- Bootstrap core JavaScript -->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Plugin JavaScript -->
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
        <script src="vendor/magnific-popup/jquery.magnific-popup.min.js"></script>

        <!-- Contact Form JavaScript -->
        <script src="js/jqBootstrapValidation.js"></script>
        <script src="js/contact_me.js"></script>

        <!-- Custom scripts for this template -->
        <script src="js/freelancer.min.js"></script>
    </form>
</body>

</html>
