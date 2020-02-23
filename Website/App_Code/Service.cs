using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.Security.Cryptography;

// NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service" in code, svc and config file together.
public class Service : IService
{
    public void DoWork()
    {
    }

    /// <summary>
    /// This function accepts email address and password. Returns bool if login is successfull
    /// 
    /// </summary>
    /// 
    public string Login(string EmailAddress, string Password)
    {
        Password = ComputeSha256Hash(Password);
        User user = new User();
        Administrator admin = new Administrator();
        string connectionString = ConfigurationManager.ConnectionStrings["Taradisyon"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);

        try
        {
            if (connection.State == ConnectionState.Closed)
                connection.Open();
            SqlCommand command = new SqlCommand("LoginUser", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@Email", EmailAddress);
            command.Parameters.AddWithValue("@Password", Password);
            SqlDataReader readeruser = command.ExecuteReader();
            readeruser.Read();

            if (readeruser.HasRows)
            {
                return readeruser[0].ToString();
            }
            else
                readeruser.Close();
            command = new SqlCommand("LoginAdmin", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@Email", EmailAddress);
            command.Parameters.AddWithValue("@Password", Password);
            SqlDataReader readeradmin = command.ExecuteReader();
            readeradmin.Read();
            if (readeradmin.HasRows)
            {
                return readeradmin[0].ToString();
            }
            else
                return "-1";
        }
        catch (Exception ex)
        {
            return ex.ToString(); ;
        }
    }

        
    /// <summary>
    /// Class containing the features of the administrator
    /// </summary>
    public bool SignUp(string FirstName, string LastName, string Gender, string Email, string Password, string Birthdate, string Nationality, string Point)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["Taradisyon"].ConnectionString;
        string query = "SELECT *" +
                "FROM [User]" +
                "WHERE EmailAddress = @Email";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.Add("@Email", SqlDbType.VarChar, 30).Value = Email;
            using (SqlDataReader reader = command.ExecuteReader())
            {
                if (reader.HasRows)
                    return false;
                else
                {
                    connection.Close();
                    query = "INSERT INTO [User] (LastName, FirstName, Gender, EmailAddress, Password, Birthdate, NationalityID, Point)" +
                        "VALUES (@LastName, @FirstName, @Gender, @Email, @Password, @Birthdate, @NationalityID, @Point)";

                    connection.Open();
                    command = new SqlCommand(query, connection);
                    command.Parameters.Add("@FirstName", SqlDbType.VarChar, 20).Value = FirstName;
                    command.Parameters.Add("@LastName", SqlDbType.VarChar, 20).Value = LastName;
                    command.Parameters.Add("@Gender", SqlDbType.Char).Value = Gender;
                    command.Parameters.Add("@Email", SqlDbType.VarChar, 30).Value = Email;
                    command.Parameters.Add("@Password", SqlDbType.Char, 64).Value = ComputeSha256Hash(Password);
                    command.Parameters.Add("@Birthdate", SqlDbType.Date).Value = Birthdate;
                    command.Parameters.Add("@NationalityID", SqlDbType.Int).Value = Nationality;
                    command.Parameters.Add("@Point", SqlDbType.Int).Value = 0;
                    command.ExecuteNonQuery();
                    connection.Close();
                }
                return true; ;
            }
        }
    }
    public List<User> GetUserData(string UserID)
    {
        List<User> data = new List<User>();
        string connectionString = ConfigurationManager.ConnectionStrings["Taradisyon"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT *" +
                "FROM [User]" +
                "WHERE ID = @ID";

            connection.Open();
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.Add("@ID", SqlDbType.Int).Value = UserID;
                using (SqlDataReader reader = command.ExecuteReader())
                    while (reader.Read())
                    {
                        User user = new User();
                        user.ID = reader.GetInt32(0);
                        user.FirstName = reader.GetString(1);
                        user.LastName = reader.GetString(2);
                        user.Gender = reader.GetChar(3);
                        user.EmailAddress = reader.GetString(4);
                        user.Password = reader.GetString(5);
                        user.BirthDate = reader.GetDateTime(6);
                        user.Nationality = reader.GetString(7);
                        user.Point = reader.GetInt32(8);
                        data.Add(user);
                    }
            }
            connection.Close();
        }
        return data;
    }

    public List<Challenge> GetChallengeByAdministrator(string ID)
    {
        Administrator admin = new Administrator();
        List<Challenge> challenge = new List<Challenge>();
        string connectionString = ConfigurationManager.ConnectionStrings["Taradisyon"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT *" +
                "FROM dbo.Challenge" +
                "WHERE AdministratorID = @AdministratorID";

            connection.Open();
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.Add("@AdministratorID", SqlDbType.Int).Value = ID;

                using (SqlDataReader reader = command.ExecuteReader())
                    while (reader.Read())
                    {
                        Challenge dare = new Challenge();
                        dare.ID = reader.GetInt32(0);
                        dare.Title = reader.GetString(1);
                        dare.Description = reader.GetString(2);
                        dare.CategoryID = reader.GetInt32(3);
                        dare.LocationID = reader.GetInt32(4);
                        dare.AdministratorID = reader.GetInt32(5);
                        dare.Emblem = reader.GetString(6);
                        dare.Point = reader.GetInt32(7);
                        dare.Picture = reader.GetString(8);
                        challenge.Add(dare);
                    }
            }
            connection.Close();
        }
        return challenge;
    }

    public List<Challenge> GetChallengeByLocationCategory(string CategoryID, string LocationID)
    {
        List<Challenge> challenge = new List<Challenge>();
        string connectionString = ConfigurationManager.ConnectionStrings["Taradisyon"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT * " +
                "FROM Challenge " +
                "WHERE LocationID = @LocationID AND CategoryID = @CategoryID";


            SqlCommand command = new SqlCommand(query, connection);
            
                command.Parameters.Add("@CategoryID", SqlDbType.Int).Value = CategoryID;
                command.Parameters.Add("@LocationID", SqlDbType.Int).Value = LocationID;
            connection.Open();
            using (SqlDataReader reader = command.ExecuteReader())
            {

                while (reader.Read())
                {
                    Challenge dare = new Challenge();
                    dare.ID = reader.GetInt32(0);
                    dare.Title = reader.GetString(1);
                    dare.Description = reader.GetString(2);
                    dare.CategoryID = reader.GetInt32(3);
                    dare.LocationID = reader.GetInt32(4);
                    dare.AdministratorID = reader.GetInt32(5);
                    dare.Emblem = reader.GetString(6);
                    dare.Point = reader.GetInt32(7);
                    dare.Picture = reader.GetString(8);
                    challenge.Add(dare);
                }
            }
            
            connection.Close();
        }
        return challenge;
    }


    public int UpdatePoints(string ID, string NewPoints)
    {
        User user = new User();
        Challenge challenge = new Challenge();
        string connectionString = ConfigurationManager.ConnectionStrings["Taradisyon"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);

        try
        {
            if (connection.State == ConnectionState.Closed)
                connection.Open();
            SqlCommand command = new SqlCommand("UpdatePoint", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@ID", ID);
            command.Parameters.AddWithValue("@NewPoints", NewPoints);
            SqlDataReader readeruser = command.ExecuteReader();
            readeruser.Read();

            if (readeruser.HasRows)
            {
                return Int32.Parse(NewPoints);
            }
            else
            {
                readeruser.Close();
                return -1;
            }
        }
        catch (Exception ex)
        {
            return -1;
        }
    }
    
    public string GenerateToken(string ChallengeID)
    {
        Token newToken = new Token();
        StringBuilder builder = new StringBuilder();
        Random random = new Random();
        char ch;
        for (int i = 0; i < 6; i++)
        {
            if (random.NextDouble() > 0.5)
            {
                ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
                builder.Append(ch);
            }
            else
            {
                ch = Convert.ToChar(random.Next(10) + 48);
                builder.Append(ch);
            }

        }
        newToken.Code = builder.ToString();
        newToken.ExpiryTime = DateTime.Now.AddMinutes(3);
        return builder.ToString();
    }

    public void ClaimToken(string ChallengeID, string Token)
    {
    }

        static string ComputeSha256Hash(string rawData)
    {
        // Create a SHA256   
        using (SHA256 sha256Hash = SHA256.Create())
        {
            // ComputeHash - returns byte array  
            byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(rawData));

            // Convert byte array to a string   
            StringBuilder builder = new StringBuilder();
            for (int i = 0; i < bytes.Length; i++)
            {
                builder.Append(bytes[i].ToString("x2"));
            }
            return builder.ToString();
        }
    }
}

