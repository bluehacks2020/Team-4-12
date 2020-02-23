using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

// NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService" in both code and config file together.
[ServiceContract]

public interface IService
{
    [OperationContract]
    void DoWork();

    [OperationContract]
    [WebInvoke(Method = "POST",
       BodyStyle = WebMessageBodyStyle.Wrapped,
       ResponseFormat = WebMessageFormat.Json)]
    string Login(string EmailAddress, string Password);

    [OperationContract]
    [WebInvoke(Method = "POST",
       BodyStyle = WebMessageBodyStyle.Wrapped,
       ResponseFormat = WebMessageFormat.Json)]
    bool SignUp(string FirstName, string LastName, string Gender, string Email, string Password, string Birthdate, string Nationality, string Point);

    [OperationContract]
    [WebInvoke(Method = "POST",
       BodyStyle = WebMessageBodyStyle.Wrapped,
       ResponseFormat = WebMessageFormat.Json)]
    List<Challenge> GetChallengeByAdministrator(string ID);


    [OperationContract]
    [WebInvoke(Method = "POST",
    BodyStyle = WebMessageBodyStyle.Wrapped,
    ResponseFormat = WebMessageFormat.Json)]
    List<Challenge> GetChallengeByLocationCategory(string CategoryID, string LocationID);


    [OperationContract]
    [WebInvoke(Method = "POST",
    BodyStyle = WebMessageBodyStyle.Wrapped,
    ResponseFormat = WebMessageFormat.Json)]
   string GenerateToken(string ChallengeID);

}
