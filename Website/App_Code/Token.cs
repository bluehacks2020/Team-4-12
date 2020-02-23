using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Token
/// </summary>
public class Token
{
        public int ID { get; set; }
        public string Code { get; set; }
        public int ChallengeID { get; set; }
        public int isClaimed { get; set; }
        public DateTime ExpiryTime { get; set; } // HH:MM:SS
}