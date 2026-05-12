// Codeunit 50025 "Envoi Mail"
// {

//     trigger OnRun()
//     begin
//         //DYS
//         // SMTPMailSetup.Get;
//         // Filename:=FileManagement.ServerTempFileName('pdf');
//         // REPORT.SAVEASPDF(50038,Filename,RecPurchaseRequest);
//         txtmail.Add('mehdihaddad.soroubat@gmail.com');
//         // SMTPMail.Create('Mail Navision : FONCIERE NAV 2017', SMTPMailSetup."User ID",
//         //        'mehdihaddad.soroubat@gmail.com', 'Mail Navision : FONCIERE NAV 2017',
//         //         'Mail Navision : FONCIERE NAV 2017, Date: ' + Format(Today), false);
//         SMTPMail.Create(txtmail, 'Mail Navision : FONCIERE NAV 2017', 'Mail Navision : FONCIERE NAV 2017, Date: ' + Format(Today), TRUE);
//         // SMTPMail.AddAttachment(Filename,'DA en Attente Approbation.pdf');
//         Email.Send(SMTPMail);
//     end;

//     var
//         //SMTPMail: Codeunit 400;
//         SMTPMail: Codeunit "Email Message";
//         Email: Codeunit Email;
//         txtmail: list of [text];
//     //DYS
//     //  SMTPMailSetup: Record 409;
// }

