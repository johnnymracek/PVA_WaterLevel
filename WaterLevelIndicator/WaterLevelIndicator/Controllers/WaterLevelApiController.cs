using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
//using System.Web.Mvc;
using System.Web.Routing;
using WaterLevelIndicator.Models.ViewModels;
using WaterLevelIndicator.Models;
using System.Web.Http;
using System.Net.Mail;


namespace WaterLevelIndicator.Controllers
{
    public class WaterLevelApiController : ApiController
    {
        private WaterLevelIndicationDBEntities _db = new WaterLevelIndicationDBEntities();

        [HttpGet]
        [Route("api/waterlevel/{selectedLabel}")]
        public IHttpActionResult GetWaterLevelData(string selectedLabel)
        {
            var apiKey = Request.Headers.GetValues("X-API-Key").FirstOrDefault(); // info from Postman 

            if (apiKey != "water_level_indication_key_198765") // info from Postman 
            {
                return Unauthorized();
            }

            var waterLevelDataReplica = _db.Database.SqlQuery<WaterLevelViewModel>("exec GetAllWaterLevelDataReplicaforCurrentBox @Label", new SqlParameter("@Label", selectedLabel.ToString())).ToList();

            var lastRecord = waterLevelDataReplica.LastOrDefault();
            if (lastRecord != null && lastRecord.Measurement >= 5)
            {
                SendWarningEmail();
            }

            return Ok(waterLevelDataReplica);
        }

   
        private void SendWarningEmail()
        {
            string smtpServer = "smtp.gmail.com";
            int smtpPort = 587; // 465 for SSL
            //string smtpUsername = "Enter your username"
            //string smtpPassword = "Password to your Google account paste here";
            const string subject = "Water Level Warning";
            const string body = "The water level has exceeded 5 meters. Please take necessary action.";

            using (SmtpClient smtpClient = new SmtpClient(smtpServer, smtpPort))
            {
                //smtpClient.Credentials = new NetworkCredential(smtpUsername, smtpPassword);
                smtpClient.EnableSsl = true;

                MailMessage mailMessage = new MailMessage
                {
                    //  From = new MailAddress("Enter your email"),
                };

                //  mailMessage.To.Add("Enter sender email");
                mailMessage.Subject = subject;
                mailMessage.Body = body;
                mailMessage.IsBodyHtml = true;

                smtpClient.Send(mailMessage);
            }
        }
    }
}

