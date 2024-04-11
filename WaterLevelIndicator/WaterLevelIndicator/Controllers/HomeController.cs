﻿using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using WaterLevelIndicator.Models;
using WaterLevelIndicator.Models.ViewModels;

namespace WaterLevelIndicator.Controllers
{
    public class HomeController : Controller
    {
        WaterLevelIndicationDBEntities _db = new WaterLevelIndicationDBEntities();
        public ActionResult Index()
        {
            var waterLevelDataReplica = _db.Database.SqlQuery<WaterLevelViewModel>("exec GetAllWaterLevelDataReplicaforCurrentBox @Label", new SqlParameter("@Label", Session["CurrentBox"]?.ToString())).ToList();

            var lastRecord = waterLevelDataReplica.LastOrDefault();
            if (lastRecord != null && lastRecord.Measurement >= 9)
            {
                SendWarningEmail();
            }

            return View(waterLevelDataReplica);
        }

        protected void SendWarningEmail()
        {
            string smtpServer = "smtp.gmail.com";
            int smtpPort = 587; // 465 for SSL
            //string smtpUsername = "Enter username"
            //string smtpPassword = "Password to your google account paste here";
            const string subject = "Water Level Warning";
            const string body = "The water level has exceeded 5 meters. Please take necessary action.";

            using (SmtpClient smtpClient = new SmtpClient(smtpServer, smtpPort))
            {
                //smtpClient.Credentials = new NetworkCredential(smtpUsername, smtpPassword);
                smtpClient.EnableSsl = true;

                MailMessage mailMessage = new MailMessage
                {
                  //  From = new MailAddress("Enter email"), 
                };

              //  mailMessage.To.Add("Enter sender "); 
                mailMessage.Subject = subject;
                mailMessage.Body = body;
                mailMessage.IsBodyHtml = true;

                //  smtpClient.Send(mailMessage);
            }
        }
    }
}
