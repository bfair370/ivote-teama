<%@ Page Title="Confirmation" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="confirm.aspx.cs" Inherits="confirm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:Label ID="LabelFeedback" runat="server" Text="">Confirm!</asp:Label><br />
    
    <asp:Panel ID="PanelHide"  runat="server">
    
    <asp:Label ID="lblForm" runat="server">
        <fieldset id="Fieldset1" class="register" runat="server">

    
        <table>
        <tr>
        <td>Please enter your new password:</td> 
        <td><asp:TextBox ID="TextBoxPassword" TextMode="Password" runat="server"></asp:TextBox><br /> </td>
        </tr>
        <tr>
        <td>Please re-enter your new password:</td> 
        <td><asp:TextBox ID="TextBoxPassword2" TextMode="Password" runat="server"></asp:TextBox>
        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="TextBoxPassword2" CssClass="red" Display="Dynamic" ControlToCompare="TextBoxPassword" ErrorMessage="Please re-enter your new password." />
        </td>
        </tr>
        </table>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="red" Display="Dynamic" ControlToValidate="TextBoxPassword" ErrorMessage="Please enter a password"></asp:RequiredFieldValidator>
            <asp:HiddenField ID="HiddenFieldPassword" runat="server" />
        <asp:Button ID="ButtonSave" runat="server" Text="Save new password" onclick="ButtonSave_Clicked" />

        </fieldset>
    </asp:Label>
    
    </asp:Panel>

    <asp:Label ID="lblConfirm" Visible="false" runat="server">
    <br />
        Your new account password has been successfully saved. You can now log into the system.<br /><br />
        <a href="Default.aspx">Click here to go to the log in page.<a />
    </asp:Label>
    
    

</asp:Content>

