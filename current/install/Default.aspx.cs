﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

using FluentNHibernate;
using FluentNHibernate.Cfg;
using FluentNHibernate.Cfg.Db;
using NHibernate.Tool.hbm2ddl;
using NHibernate;
using NHibernate.Cfg;
using DatabaseEntities;

public partial class install_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        CheckConfiguration();

        baseUrlStatus.Text = Server.MapPath("Faculty.accdb");
    }

    private void CheckConfiguration()
    {
        string baseUrl = System.Configuration.ConfigurationManager.AppSettings["baseUrl"];
        string mysqlHost = System.Configuration.ConfigurationManager.AppSettings["mysqlHost"];
        string mysqlUser = System.Configuration.ConfigurationManager.AppSettings["mysqlUser"];
        string mysqlPassword = System.Configuration.ConfigurationManager.AppSettings["mysqlPassword"];
        string mysqlDB = System.Configuration.ConfigurationManager.AppSettings["mysqlDB"];
        string fromAddress = System.Configuration.ConfigurationManager.AppSettings["fromAddress"];
        string smtpHost = System.Configuration.ConfigurationManager.AppSettings["smtpHost"];
        string smtpPort = System.Configuration.ConfigurationManager.AppSettings["smtpPort"];
        string smtpUser = System.Configuration.ConfigurationManager.AppSettings["smtpUser"];
        string smtpPassword = System.Configuration.ConfigurationManager.AppSettings["smtpPassword"];
        string smtpEnableSSL = System.Configuration.ConfigurationManager.AppSettings["smtpEnableSSL"];

        if (!String.IsNullOrEmpty(baseUrl))
        {
            baseUrlStatus.Text = baseUrl;
            baseUrlStatus.CssClass = "good";
        }
        else
        {
            baseUrlStatus.Text = "[blank]";
            baseUrlStatus.CssClass = "bad";
        }

        if (!String.IsNullOrEmpty(mysqlHost))
        {
            mysqlHostStatus.Text = mysqlHost;
            mysqlHostStatus.CssClass = "good";
        }
        else
        {
            mysqlHostStatus.Text = "[blank]";
            mysqlHostStatus.CssClass = "bad";
        }

        if (!String.IsNullOrEmpty(mysqlUser))
        {
            mysqlUserStatus.Text = mysqlUser;
            mysqlUserStatus.CssClass = "good";
        }
        else
        {
            mysqlUserStatus.Text = "[blank]";
            mysqlUserStatus.CssClass = "bad";
        }

        if (!String.IsNullOrEmpty(mysqlPassword))
        {
            mysqlPasswordStatus.Text = mysqlPassword;
            mysqlPasswordStatus.CssClass = "good";
        }
        else
        {
            mysqlPasswordStatus.Text = "[blank]";
            mysqlPasswordStatus.CssClass = "bad";
        }

        if (!String.IsNullOrEmpty(mysqlDB))
        {
            mysqlDBStatus.Text = mysqlDB;
            mysqlDBStatus.CssClass = "good";
        }
        else
        {
            mysqlDBStatus.Text = "[blank]";
            mysqlDBStatus.CssClass = "bad";
        }

        if (!String.IsNullOrEmpty(fromAddress))
        {
            fromAddressStatus.Text = fromAddress;
            fromAddressStatus.CssClass = "good";
        }
        else
        {
            fromAddressStatus.Text = "[blank]";
            fromAddressStatus.CssClass = "bad";
        }

        if (!String.IsNullOrEmpty(smtpHost))
        {
            smtpHostStatus.Text = smtpHost;
            smtpHostStatus.CssClass = "good";
        }
        else
        {
            smtpHostStatus.Text = "[blank]";
            smtpHostStatus.CssClass = "bad";
        }

        int temp;
        if (!String.IsNullOrEmpty(smtpPort) && Int32.TryParse(smtpPort, out temp))
        {
            smtpPortStatus.Text = smtpPort;
            smtpPortStatus.CssClass = "good";
        }
        else if (String.IsNullOrEmpty(smtpPort))
        {
            smtpPortStatus.Text = "[blank]";
            smtpPortStatus.CssClass = "bad";
        }
        else
        {
            smtpPortStatus.Text = smtpPort;
            smtpPortStatus.CssClass = "bad";
        }

        if (!String.IsNullOrEmpty(smtpUser))
        {
            smtpUserStatus.Text = smtpUser;
            smtpUserStatus.CssClass = "good";
        }
        else
        {
            smtpUserStatus.Text = "[blank]";
            smtpUserStatus.CssClass = "neutral";
        }

        if (!String.IsNullOrEmpty(smtpPassword))
        {
            smtpPasswordStatus.Text = smtpPassword;
            smtpPasswordStatus.CssClass = "good";
        }
        else
        {
            smtpPasswordStatus.Text = "[blank]";
            smtpPasswordStatus.CssClass = "neutral";
        }

        if (smtpEnableSSL == "true" || smtpEnableSSL == "false")
        {
            smtpEnableSSLStatus.Text = smtpEnableSSL;
            smtpEnableSSLStatus.CssClass = "good";
        }
        else if (String.IsNullOrEmpty(smtpEnableSSL))
        {
            smtpEnableSSLStatus.Text = "[blank]";
            smtpEnableSSLStatus.CssClass = "bad";
        }
        else
        {
            smtpEnableSSLStatus.Text = smtpEnableSSL;
            smtpEnableSSLStatus.CssClass = "bad";
        }


    }
    protected void checkSettings_Click(object sender, EventArgs e)
    {
        CheckConfiguration();
    }

    protected void createScheme_Click(object sender, EventArgs e)
    {
        databaseLogic dbLogic = new databaseLogic();
        dbLogic.createSchema();

        DatabaseEntities.NHibernateHelper.CreateSessionFactoryAndGenerateSchema();

        createSchemaStatus.Visible = true;
        createScheme.Enabled = false;
    }

    protected void createUser_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid)
            return;

        ISession session = DatabaseEntities.NHibernateHelper.CreateSessionFactory().OpenSession();
        ITransaction transaction = session.BeginTransaction();

        DatabaseEntities.User user = new DatabaseEntities.User();
        user.FirstName = "Default";
        user.LastName = "Admin";
        user.Email = email.Text;
        user.Password = DatabaseEntities.User.Hash(password.Text);
        user.PasswordHint = "";
        user.CanVote = false;
        user.CurrentCommittee = -1;
        user.Department = DepartmentType.Staff;
        user.IsAdmin = true;
        user.IsBargainingUnit = false;
        user.IsNEC = false;
        user.IsTenured = false;
        user.IsUnion = false;
        user.LastLogin = DateTime.Now;
        user.CanVote = false;

        DatabaseEntities.NHibernateHelper.UpdateDatabase(session, user);

        DatabaseEntities.NHibernateHelper.Finished(transaction);

        createUserStatus.Visible = true;
        createUser.Enabled = false;
    }

    protected void importUsers_Click(object sender, EventArgs e)
    {
        ISession session = NHibernateHelper.CreateSessionFactory().OpenSession();
        DatabaseEntities.User.ImportUsers(session, Server.MapPath("Faculty.accdb"));
        session.Flush();
        importUsers.Enabled = false;
        importUserStatus.Visible = true;
    }
}