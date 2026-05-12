Codeunit 8001433 "SMTP Connector Integration"
{
    // //+BGW-SMTP+ AC 10/01/10


    trigger OnRun()
    begin
    end;

    var
        //GL2024  dotnet non compatible  gSMTPClient: dotnet NavSmtpClient;
        //GL2024 Automation non compatible  gSMTPClientClassic: Automation;
        gSubject: Text[1024];
        gBody: BigText;
        gTo: Text[1024];
        gFrom: Text[1024];
        gBodyIsHtml: Boolean;


    /*
    //GL2024 Automation non compatible
      procedure Constructor()
      var
          lSMTPMailSetup: Record 409;
      begin
          lSMTPMailSetup.Get;
          if ISSERVICETIER then begin
              lInitialise(gSMTPClient);
              lLoadConnexion(gSMTPClient, lSMTPMailSetup);
          end else begin
              lInitialiseClassic(gSMTPClientClassic);
              lLoadConnexionClassic(gSMTPClientClassic, lSMTPMailSetup);
          end;
      end;
  */

    /*    //GL2024Dotnet non compatible


     procedure Desctructor()
      begin
          if ISSERVICETIER then
              Clear(gSMTPClient)
         else
              Clear(gSMTPClientClassic);
      end;

  */
    /* 
    //GL2024 Automation non compatible
    procedure Send()
     var
         lSMTPMailSetup: Record 409;
     begin
         lCheckMessageAttribut;
         if ISSERVICETIER then begin
             lSendMessage(gSMTPClient, gBodyIsHtml);
         end else begin
             lSendMessageClassic(gSMTPClientClassic, gBodyIsHtml);
         end;
     end;

 */
    procedure SetSubject(pValue: Text[1024])
    begin
        gSubject := pValue;
    end;


    procedure SetBodyFromText(pValue: Text[1024])
    begin
        Clear(gBody);
        gBody.AddText(pValue);
    end;


    procedure SetBodyFromInStream(pValue: InStream)
    var
        lOutStream: OutStream;
    begin
        CopyStream(lOutStream, pValue);
        gBody.Write(lOutStream);
    end;


    procedure SetBodyIsHtml(pValue: Boolean)
    begin
        gBodyIsHtml := pValue;
    end;


    procedure AppendBody(pValue: Text[1024])
    begin
        gBody.AddText(pValue);
    end;


    procedure SetToAdress(pValue: Text[1024])
    begin
        gTo := pValue;
    end;


    procedure SetFromAddress(pValue: Text[1024])
    begin
        gFrom := pValue;
    end;

    /* 
       //GL2024 Automation non compatible
      local procedure lInitialise(var pSMTPClient: dotnet NavSmtpClient)
       begin
           pSMTPClient := pSMTPClient.NavSmtpClient();
       end;

       local procedure lLoadConnexion(var pSMTPClient: dotnet NavSmtpClient; pSMTPMailSetup: Record 409)
       begin
           pSMTPClient.Host := pSMTPMailSetup."SMTP Server";
           if pSMTPMailSetup.Port <> 0 then
               pSMTPClient.Port := pSMTPMailSetup.Port;
           pSMTPClient.UseDefaultCredentials := pSMTPMailSetup.Authentication = pSMTPMailSetup.Authentication::NTLM;
           pSMTPClient.EnableSsl := pSMTPMailSetup."SSL/TLS";
           pSMTPClient.UserConnexion := pSMTPMailSetup."User ID";
           pSMTPClient.PwdConnexion := pSMTPMailSetup.Password;
       end;

       local procedure lSendMessage(var pSMTPClient: dotnet NavSmtpClient; pIsBodyHtml: Boolean)
       begin
           pSMTPClient.Subject(gSubject);
           pSMTPClient.IsBodyHtml(pIsBodyHtml);
           pSMTPClient.Body(gBody);
           pSMTPClient.From(gFrom);
           pSMTPClient."To"(gTo);
           pSMTPClient.Send();
       end;

       local procedure lInitialiseClassic(var pSMTPClient: Automation)
       begin
           if ISCLEAR(pSMTPClient) then
               Create(pSMTPClient);
       end;

       local procedure lLoadConnexionClassic(var pSMTPClient: Automation; pSMTPMailSetup: Record 409)
       begin
           pSMTPClient.Host := pSMTPMailSetup."SMTP Server";
           if pSMTPMailSetup.Port <> 0 then
               pSMTPClient.Port := pSMTPMailSetup.Port;
           pSMTPClient.SSLEnabled := pSMTPMailSetup."SSL/TLS";
           pSMTPClient.UseDefaultCredentials := pSMTPMailSetup.Authentication = pSMTPMailSetup.Authentication::NTLM;
           if pSMTPMailSetup.Authentication = pSMTPMailSetup.Authentication::Basic then begin
               pSMTPClient.UserNameConnexion := pSMTPMailSetup."User ID";
               pSMTPClient.PasswordConnexion := pSMTPMailSetup.Password;
           end;
       end;
   */
    /* 
    //GL2024 Automation non compatible

    local procedure lSendMessageClassic(var pSMTPClient: Automation; pIsBodyHtml: Boolean)
     var
         lTextBody: Text[1024];
         lPos: Integer;
         lLenght: Integer;
     begin
         pSMTPClient.Subject(gSubject);
         pSMTPClient.BodyHtml(pIsBodyHtml);
         lPos := 1;
         while lPos <= gBody.Length do begin
             if gBody.Length - lPos > 1000 then
                 lLenght := 1000
             else
                 lLenght := gBody.Length - lPos + 1;
             gBody.GetSubText(lTextBody, lPos, lLenght);

             pSMTPClient.AppendBody(lTextBody);
             lPos := lLenght + 1;
         end;

         pSMTPClient.FromAdress(gFrom);
         pSMTPClient.ToAdress(gTo);
         pSMTPClient.Send();
     end;
 */
    local procedure lCheckMessageAttribut()
    begin
    end;
}

