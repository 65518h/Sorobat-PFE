codeunit 52048894 PRcodeunit
{
    trigger OnRun()
    begin

    end;

    procedure RefusNotification(UserIdr: Code[50]; NumDemande: Code[50]; RefusedBy: Code[30]; Reason: Text);
    var
        mymail: Codeunit "Email Message";
        EmailMessage: Codeunit "Email";
        Subject: Text;
        Recipient: Text;
        Body: Text;
        Recluser: Record 91;
        fromUser: Record 91;
        Recl38: Record 38;
        Recl312: Record 312;
        BoolEnvoie: Boolean;
        Recl454: Record 454;
        RecUserAdL: Record 91;
        LEmailtosend: Text;
        LEmailtoCC: Text;
        RecUserAppL: Record 91;
        RecUserAdA: Record 91;
        txtmail: list of [text];
        txtmail2: list of [text];
        RecGDemAcht: Record "Purchase Request";
        txtmailCC: list of [text];
        RecipientType: Enum "Email Recipient Type";
        RecUserController: Record "User Setup";
        RecPurchaseSetup: Record "Purchases & Payables Setup";
    begin

        CLEAR(mymail);
        RecPurchaseSetup.Reset();
        RecPurchaseSetup.Get();
        Subject := 'Refus Demande Achat';
        Recluser.GET(UserIdr);
        Body := 'Bonjour, ' + Recluser."User ID" + '<p>';
        RecUserAdL.RESET;
        RecGDemAcht.GET(NumDemande);
        RecUserAdL.GET(RecGDemAcht."User ID");
        LEmailtosend := RecUserAdL."E-Mail";
        // RecUserAdL.RESET;
        // RecUserAdL.SETRANGE(RecUserAdL."Traiter DA", TRUE);
        // IF RecUserAdL.FINDFIRST THEN
        //     LEmailtosend := LEmailtosend + ';' + FORMAT(RecUserAdL."E-Mail");
        // RecUserAdA.RESET;
        // RecUserAdA.SETRANGE(RecUserAdA."Appro. Controle De Gestion", TRUE);
        // IF RecUserAdA.FINDFIRST THEN
        //     repeat
        LEmailtoCC := RecUserAdA."E-Mail";
        Clear(txtmail);
        fromUser.GET(RefusedBy);
        //txtmail.Add(FORMAT(LEmailtosend) + ';' + FORMAT(LEmailtoCC));
        //txtmail2.Add(Emailtosend);
        txtmail.add(RecUserAdA."E-Mail");
        //IF LEmailtosend <> '' THEN BEGIN
        //  IF LEmailtoCC <> '' THEN
        mymail.Create(LEmailtosend, Subject, Body, TRUE);
        if RecUserController.Get(RecPurchaseSetup."management controller 1") then begin
            if RecUserController."E-Mail" <> '' then
                mymail.AddRecipient(RecipientType::Cc, RecUserController."E-Mail");
        end;
        if RecUserController.Get(RecPurchaseSetup."management controller 2") then begin
            if RecUserController."E-Mail" <> '' then
                mymail.AddRecipient(RecipientType::Cc, RecUserController."E-Mail");
        end;
        //ELSE
        //  SMTP.CreateMessage(fromUser.Nom, Recluser."E-Mail", txtmail2, Subject, Body, TRUE);
        Body := '<p>La demande achat  ' + NumDemande + ' a été rejetée par Mr ' + fromUser."User ID" + '</p>';
        mymail.AppendToBody(Body);
        BoolEnvoie := FALSE;


        Body := '';
        Body := '<p> Motif: ' + Reason +
                 '<p>';
        mymail.AppendToBody(Body);




        //  SMTP.AppendBody(Body);

        Body := '</p>' + '</p>cordialement.,</p>';
        mymail.AppendToBody(Body);



        EmailMessage.Send(mymail);
        //  END;
        // until RecUserAdA.Next() = 0;
    end;
    //HS
    procedure Ordre_Trans_Notif(pNote: BigText; pNotify: Boolean; pUserID: Text[132]; pRecordID: RecordID; TransShptHeader: Record "Transfer Shipment Header"; TransferHeader: Record "Transfer Header");
    var
        lRecordLink: Record 2000000068;
        lRecRef: RecordRef;
        lchar1: Char;
        RecUserAd: Record "User Setup";
        lchar2: Char;
        lis: InStream;
        lNewID: Integer;
        los: OutStream;
        lTextToWrite: BigText;
        lTextSmall: Text[250];
        TxtDesc: TextConst ENU = 'Goods Insurance N° : %1', FRA = 'Devis N° : %1';
        G_RecLink_ID: Integer;
        Url1: Text;
        lDescription: Text;
        RecUser: Record 91;
        EmailBody: array[2] of Text[1024];
        cr: Text;
        lf: Text;
        BodyText: Text[1024];
        BoolEditable: Boolean;
        Err03: TextConst ENU = 'Invalid Email for user %1, please contact your administrator', FRA = 'Email Incorrect,Merci de voir avec l''administrateur';
        Email1: TextConst ENU = 'Dear %1,', FRA = 'Bonjour,';
        Email2: Label 'Please Check and post the below link';
        mymail: Codeunit "Email Message";
        EmailMessage: Codeunit "Email";
        filename: Text[100];
        Testfile: Boolean;
        I: Integer;
        RecProdSet: Record 99000765;
        RecUserNot: Record 2000000120;
        txt001: TextConst FRA = '<a href="%1">NAV Link</a>';
        txtmail: list of [text];
        txturlEXt: text[250];
        ReclPrchLine: Record "Purchase Request Line";
        RecPurchaseSetup: Record "Purchases & Payables Setup";
        ReclAxeactivite: Record "Dimension Value";
        RecUserName: Record "User Setup";
        TxtURL2: Text[250];
        RecUSERid: Record "User Setup";
        txtmailCC: list of [text];
        RecipientType: Enum "Email Recipient Type";
        RecUserController: Record "User Setup";
        RecTransferHeader: Record "Transfer Header";
        RecLocation: Record Location;
        TransShptLine: Record "Transfer Shipment Line";

    begin
        CLEAR(EmailMessage);
        RecLocation.Get(TransShptHeader."Transfer-to Code");
        if RecTransferHeader.Get(TransShptHeader."Transfer Order No.") then;
        I := 0;
        RecPurchaseSetup.Reset();
        RecPurchaseSetup.Get();
        RecUSERid.GET(USERID);
        IF pNote.LENGTH <= 255 THEN BEGIN
            lchar1 := pNote.LENGTH;
            lTextToWrite.ADDTEXT(FORMAT(lchar1));
        END ELSE BEGIN
            lchar1 := 128 + (pNote.LENGTH - 256) MOD 128;
            lchar2 := 2 + (pNote.LENGTH - 256) DIV 128;
            lTextToWrite.ADDTEXT(FORMAT(lchar1) + FORMAT(lchar2));
        END;
        lTextToWrite.ADDTEXT(pNote);
        IF pUserID <> '' THEN
            IF COPYSTR(pUserID, STRLEN(pUserID)) = ',' THEN
                pUserID := COPYSTR(pUserID, 1, STRLEN(pUserID) - 1);

        //pNote.GETSUBTEXT(lTextSmall,1);
        G_RecLink_ID := 0;
        lRecRef.GET(pRecordID);
        lNewID := lRecRef.ADDLINK(lTextSmall);
        lRecordLink.GET(lNewID);
        G_RecLink_ID := lNewID;
        TxtURL2 := format(GETURL(CLIENTTYPE::Web, COMPANYNAME, OBJECTTYPE::Page, PAGE::"Transfer Order", TransferHeader));
        //Message(TxtURL2);
        TxtURL2 := CopyStr(TxtURL2, 1, TxtURL2.IndexOf('/?company'));
        //Message(TxtURL2);
        lRecordLink.CALCFIELDS(Note);
        lRecordLink.Note.CREATEOUTSTREAM(los);
        lTextToWrite.WRITE(los);
        lRecordLink.Type := lRecordLink.Type::Note;
        lRecordLink.Notify := pNotify;
        lRecordLink."To User ID" := RecUSERid."User ID";
        lRecordLink."User ID" := LOWERCASE(lRecordLink."User ID");
        // Url1 := GETURL(CURRENTCLIENTTYPE::Web, COMPANYNAME, OBJECTTYPE::Page, 51000, PurchReq);
        lRecordLink.URL1 := Url1;
        lDescription := STRSUBSTNO(TxtDesc, TransferHeader."No.");
        lRecordLink.Description := lDescription;
        lRecordLink.MODIFY;
        //<<Send Email
        // Message(format(GETURL(CLIENTTYPE::Web, COMPANYNAME, OBJECTTYPE::Page, PAGE::"Purchase Request", PurchReq)));
        //txturlEXt := format(GETURL(CLIENTTYPE::Web, COMPANYNAME, OBJECTTYPE::Page, PAGE::"Purchase Request", PurchReq).Replace('srv-bc-test:48900', '196.179.196.49:5454'));      // Message(txturlEXt);
        // Message(RecPurchaseSetup."Lien Externe");
        txturlEXt := format(GETURL(CLIENTTYPE::Web, COMPANYNAME, OBJECTTYPE::Page, PAGE::"Transfer Order", TransferHeader).Replace(TxtURL2, format(RecPurchaseSetup."Lien Externe")));      // Message(txturlEXt);
                                                                                                                                                                                            // Message(txturlEXt);

        //Error('Test');
        EmailBody[1] := STRSUBSTNO(Email1);

        EmailBody[2] := COMPANYNAME + ' : ' + 'Ordre transfert à traiter,   N° : ' + TransferHeader."No.";

        cr := '<p>';

        //Url1 := (GETURL(CLIENTTYPE::Web, COMPANYNAME, OBJECTTYPE::Page, PAGE::"Purchase Request", PurchReq).Replace('srv-bc-test:48900', '192.168.3.103:8890'));
        //Url1 := (GETURL(CLIENTTYPE::Web, COMPANYNAME, OBJECTTYPE::Page, PAGE::"Purchase Request", PurchReq).Replace('localhost:8890', '192.168.3.103:8890'));
        Url1 := format(GETURL(CLIENTTYPE::Web, COMPANYNAME, OBJECTTYPE::Page, PAGE::"Transfer Order", TransferHeader).Replace(TxtURL2, format(RecPurchaseSetup."Lien Interne")));      // Message(txturlEXt);

        BodyText := EmailBody[1] + FORMAT(cr) + EmailBody[2] + FORMAT(cr) + FORMAT(lf);


        if i > 0 then
            Clear(txtmail);

        I := I + 1;
        txtmail.Add(RecLocation."E-Mail");


        //  Message(RecUserAd."E-Mail");
        // Message('Sender : ' + RecUSERid."User ID");
        // Message('Receiver To : ' + format(txtmail.Get(1)));
        //IF RecUser."E-Mail" <> '' THEN BEGIN
        IF RecLocation."E-Mail" <> '' THEN BEGIN
            mymail.Create(RecLocation."E-Mail", STRSUBSTNO(COMPANYNAME + ' : ' + 'Ordre transfert à traiter,   N° : ' + TransferHeader."No."), BodyText, TRUE);
            if RecUserController.Get(RecPurchaseSetup."management controller 1") then begin
                if RecUserController."E-Mail" <> '' then
                    mymail.AddRecipient(RecipientType::Cc, RecUserController."E-Mail");
            end;
            if RecUserController.Get(RecPurchaseSetup."management controller 2") then begin
                if RecUserController."E-Mail" <> '' then
                    mymail.AddRecipient(RecipientType::Cc, RecUserController."E-Mail");
            end;
            mymail.AppendToBody('<table border="1" style="border: 1px Solid Black;text-align: center;" >');
            mymail.AppendToBody('<tr>');
            mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:200px" >%1</td>', 'N° transfert'));
            mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:200px" >%1</td>', 'Code prov. transfert'));
            mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:200px" >%1</td>', 'Code dest. transfert'));
            mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:250px" >%1</td>', 'N° Article'));
            mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:250px" >%1</td>', 'Description'));
            mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:200px" >%1</td>', 'Qté expédiée'));
            mymail.AppendToBody('</tr>');
            TransShptLine.Reset();
            TransShptLine.SetRange("Document No.", TransShptHeader."No.");
            if TransShptLine.FindSet() then begin
                repeat
                    mymail.AppendToBody('<tr>');
                    mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:200px" >%1</td>', TransShptHeader."Transfer Order No."));
                    mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:200px" >%1</td>', TransShptHeader."Transfer-from Code"));
                    mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:200px" >%1</td>', TransShptHeader."Transfer-to Code"));
                    mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:250px">%1</td>', TransShptLine."Item No."));
                    mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:250px">%1</td>', TransShptLine.Description));
                    mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:200px">%1</td>', TransShptLine.Quantity));
                    mymail.AppendToBody('</tr>');
                until TransShptLine.Next() = 0;
            END;
            mymail.AppendToBody('</table>');
            mymail.AppendToBody(StrSubstNo('<a href=' + Url1 + '>Interne :  Lien Ordre transfert  </a><P>'));
            mymail.AppendToBody(StrSubstNo('<a href=' + txturlEXt + '>Externe :  Lien Ordre transfert  </a>'));
            //   mymail.AppendToBody(Url1);
            mymail.AppendToBody(FORMAT(cr));
            mymail.AppendToBody('cordialement.');
        END
        ELSE
            ERROR(Err03, RecLocation."E-Mail");
        EmailMessage.Send(mymail);


    end;
    //>>Send  Email


    procedure ApprouvNotification(NumDemande: Code[50]);
    var
        mymail: Codeunit "Email Message";
        EmailMessage: Codeunit "Email";
        Subject: Text;
        Recipient: Text;
        Body: Text;
        Recluser: Record 91;
        fromUser: Record 91;
        Recl38: Record 38;
        Recl312: Record 312;
        BoolEnvoie: Boolean;
        Recl454: Record 454;
        RecUserAdL: Record 91;
        LEmailtosend: Text;
        LEmailtoCC: Text;
        RecUserAppL: Record 91;
        RecUserAdA: Record 91;
        txtmail: list of [text];
        txtmailCC: list of [text];
        txtmail2: list of [text];
        ReclPrchLine: Record "Purchase Request Line";
        RecPurchaseSetup: Record "Purchases & Payables Setup";
        ReclAxeActivite: Record "Dimension Value";
        RecUserName: Record "User Setup";
        RecGDemAcht: Record "Purchase Request";
        RecipientType: Enum "Email Recipient Type";
        RecUserController: Record "User Setup";
    begin
        RecPurchaseSetup.Reset();
        RecPurchaseSetup.Get();


        CLEAR(EmailMessage);

        Subject := COMPANYNAME + ' : ' + 'Approuver Demande Achat';
        RecGDemAcht.GET(NumDemande);
        Recluser.GET(RecGDemAcht."User ID");
        Body := 'Bonjour, ' + Recluser."User ID" + '<p>';
        RecUserAdL.RESET;

        RecUserAdL.GET(RecGDemAcht."User ID");
        LEmailtosend := RecUserAdL."E-Mail";
        // RecUserAdL.RESET;

        //RecUserAdL.SETRANGE(RecUserAdL."Traiter DA", TRUE);
        //IF RecUserAdL.FINDFIRST THEN;

        // LEmailtosend := LEmailtosend + ';' + FORMAT(RecUserAdL."E-Mail");
        // RecUserAdA.RESET;
        // RecUserAdA.SETRANGE(RecUserAdA."Appro. DG", TRUE);
        // IF RecUserAdA.FINDFIRST THEN;

        //   repeat
        LEmailtoCC := RecUserAdA."E-Mail";

        //MMS

        Clear(txtmail);
        fromUser.GET(UserId);
        //txtmail.Add(FORMAT(LEmailtosend) + ';' + FORMAT(LEmailtoCC));
        //txtmail2.Add(Emailtosend);
        //  txtmail.add(RecUserAdL."E-Mail");
        IF Recluser."E-Mail" <> '' THEN BEGIN
            /*if RecPurchaseSetup."Mail DG" <> '' THEN
                txtmail.Add(RecPurchaseSetup."Mail DG");
            if RecPurchaseSetup."Mail DG2" <> '' THEN
                txtmail.Add(RecPurchaseSetup."Mail DG2");
            if RecPurchaseSetup."Mail CG" <> '' THEN
                txtmail.Add(RecPurchaseSetup."Mail CG");*/
            //Message(RecPurchaseSetup."Mail DG");
            //Message(RecPurchaseSetup."Mail DG2");
            //Message(RecPurchaseSetup."Mail CG");
            //IF LEmailtosen, <> '' THEN BEGIN
            //  IF LEmailtoCC <> '' THEN
            mymail.Create(Recluser."E-Mail", Subject, Body, TRUE);
            // if RecPurchaseSetup."management controlleractivated" then begin
            if RecUserController.Get(RecPurchaseSetup."management controller 1") then begin
                if RecUserController."E-Mail" <> '' then
                    mymail.AddRecipient(RecipientType::Cc, RecUserController."E-Mail");
            end;
            if RecUserController.Get(RecPurchaseSetup."management controller 2") then begin
                if RecUserController."E-Mail" <> '' then
                    mymail.AddRecipient(RecipientType::Cc, RecUserController."E-Mail");
            end;
            //  end;
            //ELSE
            //  SMTP.CreateMessage(fromUser.Nom, Recluser."E-Mail", txtmail2, Subject, Body, TRUE);
            Body := '<p>La demande achat  ' + NumDemande + ' a été approuvée par Mr ' + fromUser."User ID" + '</p>';
            mymail.AppendToBody(Body);
            mymail.AppendToBody('<table border="1">');
            mymail.AppendToBody('<tr>');
            mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', 'N° Projet'));
            mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', 'N° tâche Projet'));
            mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', 'Demandeur'));
            mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', 'N° Article'));
            mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', 'Description'));
            mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', 'Quantité'));
            //  SMTP.AppendToBody(STRSUBSTNO('<td>%1</td>', 'Commentaire'));
            mymail.AppendToBody('</tr>');
            ReclPrchLine.Reset();
            ReclPrchLine.SetRange("Document No.", NumDemande);
            ReclPrchLine.SetRange("Statut", ReclPrchLine."Statut"::approved);
            if ReclPrchLine.FindFirst() then begin
                repeat
                    // if ReclPrchLine."Ligne Status" <> ReclPrchLine."Ligne Status"::Refused then begin
                    ReclAxeActivite.Reset();
                    ReclAxeActivite.SetRange(Code, ReclPrchLine."Shortcut Dimension 1 Code");
                    IF ReclAxeActivite.FindFirst() THEN;
                    RecUserName.Get(RecGDemAcht."User ID");
                    mymail.AppendToBody('<tr>');
                    mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', ReclPrchLine."Job No."));
                    mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', ReclPrchLine."Job Task No."));
                    mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', RecUserName."User ID"));
                    mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', ReclPrchLine."No."));
                    mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', ReclPrchLine.Description));
                    mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', ReclPrchLine.Quantity));
                    // SMTP.AppendToBody(STRSUBSTNO('<td>%1</td>', ReclPrchLine.Affectation));
                    mymail.AppendToBody('</tr>');
                //  end;
                until ReclPrchLine.Next() = 0;
            END;
            BoolEnvoie := FALSE;
            mymail.AppendToBody('</table>');
            Body := '';
            //  Body := '<p> Motif: ' + comment +
            // '<p>';
            mymail.AppendToBody(Body);
            ReclPrchLine.Reset();
            ReclPrchLine.SetRange("Document No.", NumDemande);
            ReclPrchLine.SetRange("Statut", ReclPrchLine."Statut"::refused);
            if ReclPrchLine.FindSet() then begin
                Body := '<p>' + Format(ReclPrchLine.Count()) + ' Ligne(s) demande achat   ' + NumDemande + ' ont été refusés par ' + fromUser."User ID" + '</p>';
                mymail.AppendToBody(Body);
                mymail.AppendToBody('<table border="1">');
                mymail.AppendToBody('<tr>');
                mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', 'N° Projet'));
                mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', 'N° tâche Projet'));
                mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', 'Demandeur'));
                mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', 'N° Article'));
                mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', 'Description'));
                mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', 'Quantité'));
                mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', 'Motifs Refus'));
                //  SMTP.AppendToBody(STRSUBSTNO('<td>%1</td>', 'Commentaire'));
                mymail.AppendToBody('</tr>');
                repeat
                    mymail.AppendToBody('<tr>');
                    mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', ReclPrchLine."Job No."));
                    mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', ReclPrchLine."Job Task No."));
                    mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', RecUserName."User ID"));
                    mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', ReclPrchLine."No."));
                    mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', ReclPrchLine.Description));
                    mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', ReclPrchLine.Quantity));
                    mymail.AppendToBody(STRSUBSTNO('<td>%1</td>', ReclPrchLine."Reason Refusal"));
                    // SMTP.AppendToBody(STRSUBSTNO('<td>%1</td>', ReclPrchLine.Affectation));
                    mymail.AppendToBody('</tr>');
                until ReclPrchLine.Next() = 0;
            end;
            mymail.AppendToBody('</table>');
            //  SMTP.AppendToBody(Body);
            Body := '</p>' + '</p>cordialement.,</p>';
            mymail.AppendToBody(Body);
            EmailMessage.Send(mymail);
        END;
        //  END;
        //until RecUserAdA.Next() = 0;
    end;

    procedure CreateNotification(pNote: BigText; pNotify: Boolean; pUserID: Text[132]; pRecordID: RecordID; PurchReq: Record "Purchase Request"; CEO: Boolean);
    var
        lRecordLink: Record 2000000068;
        lRecRef: RecordRef;
        lchar1: Char;
        RecUserAd: Record "User Setup";
        lchar2: Char;
        lis: InStream;
        lNewID: Integer;
        los: OutStream;
        lTextToWrite: BigText;
        lTextSmall: Text[250];
        TxtDesc: TextConst ENU = 'Goods Insurance N° : %1', FRA = 'Devis N° : %1';
        G_RecLink_ID: Integer;
        Url1: Text;
        lDescription: Text;
        RecUser: Record 91;
        EmailBody: array[2] of Text[1024];
        cr: Text;
        lf: Text;
        BodyText: Text[1024];
        BoolEditable: Boolean;
        Err03: TextConst ENU = 'Invalid Email for user %1, please contact your administrator', FRA = 'Email Incorrect,Merci de voir avec l''administrateur';
        Email1: TextConst ENU = 'Dear %1,', FRA = 'Bonjour,';
        Email2: Label 'Please Check and post the below link';
        mymail: Codeunit "Email Message";
        EmailMessage: Codeunit "Email";
        filename: Text[100];
        Testfile: Boolean;
        I: Integer;
        RecProdSet: Record 99000765;
        RecUserNot: Record 2000000120;
        txt001: TextConst FRA = '<a href="%1">NAV Link</a>';
        txtmail: list of [text];
        txturlEXt: text[250];
        ReclPrchLine: Record "Purchase Request Line";
        RecPurchaseSetup: Record "Purchases & Payables Setup";
        ReclAxeactivite: Record "Dimension Value";
        RecUserName: Record "User Setup";
        TxtURL2: Text[250];
        RecUSERid: Record "User Setup";
        txtmailCC: list of [text];
        RecipientType: Enum "Email Recipient Type";
        RecUserController: Record "User Setup";

    begin
        CLEAR(EmailMessage);
        I := 0;
        RecPurchaseSetup.Reset();
        RecPurchaseSetup.Get();
        RecUSERid.GET(USERID);
        IF pNote.LENGTH <= 255 THEN BEGIN
            lchar1 := pNote.LENGTH;
            lTextToWrite.ADDTEXT(FORMAT(lchar1));
        END ELSE BEGIN
            lchar1 := 128 + (pNote.LENGTH - 256) MOD 128;
            lchar2 := 2 + (pNote.LENGTH - 256) DIV 128;
            lTextToWrite.ADDTEXT(FORMAT(lchar1) + FORMAT(lchar2));
        END;
        lTextToWrite.ADDTEXT(pNote);
        IF pUserID <> '' THEN
            IF COPYSTR(pUserID, STRLEN(pUserID)) = ',' THEN
                pUserID := COPYSTR(pUserID, 1, STRLEN(pUserID) - 1);

        //pNote.GETSUBTEXT(lTextSmall,1);
        G_RecLink_ID := 0;
        lRecRef.GET(pRecordID);
        lNewID := lRecRef.ADDLINK(lTextSmall);
        lRecordLink.GET(lNewID);
        G_RecLink_ID := lNewID;
        TxtURL2 := format(GETURL(CLIENTTYPE::Web, COMPANYNAME, OBJECTTYPE::Page, PAGE::"Purchase Request Header", PurchReq));
        //Message(TxtURL2);
        TxtURL2 := CopyStr(TxtURL2, 1, TxtURL2.IndexOf('/?company'));
        //Message(TxtURL2);
        lRecordLink.CALCFIELDS(Note);
        lRecordLink.Note.CREATEOUTSTREAM(los);
        lTextToWrite.WRITE(los);
        lRecordLink.Type := lRecordLink.Type::Note;
        lRecordLink.Notify := pNotify;
        lRecordLink."To User ID" := RecUSERid."User ID";
        lRecordLink."User ID" := LOWERCASE(lRecordLink."User ID");
        // Url1 := GETURL(CURRENTCLIENTTYPE::Web, COMPANYNAME, OBJECTTYPE::Page, 51000, PurchReq);
        lRecordLink.URL1 := Url1;
        lDescription := STRSUBSTNO(TxtDesc, PurchReq."No.");
        lRecordLink.Description := lDescription;
        lRecordLink.MODIFY;
        //<<Send Email
        // Message(format(GETURL(CLIENTTYPE::Web, COMPANYNAME, OBJECTTYPE::Page, PAGE::"Purchase Request", PurchReq)));
        //txturlEXt := format(GETURL(CLIENTTYPE::Web, COMPANYNAME, OBJECTTYPE::Page, PAGE::"Purchase Request", PurchReq).Replace('srv-bc-test:48900', '196.179.196.49:5454'));      // Message(txturlEXt);
        // Message(RecPurchaseSetup."Lien Externe");
        txturlEXt := format(GETURL(CLIENTTYPE::Web, COMPANYNAME, OBJECTTYPE::Page, PAGE::"Purchase Request Header", PurchReq).Replace(TxtURL2, format(RecPurchaseSetup."Lien Externe")));      // Message(txturlEXt);
                                                                                                                                                                                               // Message(txturlEXt);

        //Error('Test');
        EmailBody[1] := STRSUBSTNO(Email1);

        EmailBody[2] := COMPANYNAME + ' : ' + 'demande achat à traiter,   N° : ' + PurchReq."No.";

        cr := '<p>';

        //Url1 := (GETURL(CLIENTTYPE::Web, COMPANYNAME, OBJECTTYPE::Page, PAGE::"Purchase Request", PurchReq).Replace('srv-bc-test:48900', '192.168.3.103:8890'));
        //Url1 := (GETURL(CLIENTTYPE::Web, COMPANYNAME, OBJECTTYPE::Page, PAGE::"Purchase Request", PurchReq).Replace('localhost:8890', '192.168.3.103:8890'));
        Url1 := format(GETURL(CLIENTTYPE::Web, COMPANYNAME, OBJECTTYPE::Page, PAGE::"Purchase Request Header", PurchReq).Replace(TxtURL2, format(RecPurchaseSetup."Lien Interne")));      // Message(txturlEXt);

        BodyText := EmailBody[1] + FORMAT(cr) + EmailBody[2] + FORMAT(cr) + FORMAT(lf);
        //CLEAR(mymail);


        RecUserAd.RESET;
        //    RecUserAd.SETRANGE(RecUserAd."Appro. DG", TRUE);
        RecUserAd.SetRange("User ID", RecUSERid."Approver ID DA");


        // RecUserAd.SetRange("License Type", RecUserAd."License Type"::"Full User");
        //RecUserAd.SETRANGE(RecUserAd."Traiter DA", TRUE);


        IF RecUserAd.FINDFIRST THEN begin

            //  if RecPurchaseSetup."Mail DG" <> '' THEN
            //    txtmail.Add(RecPurchaseSetup."Mail DG");
            //if RecPurchaseSetup."Mail DG2" <> '' THEN
            //  txtmail.Add(RecPurchaseSetup."Mail DG2");
            //if RecPurchaseSetup."Mail CG" <> '' THEN
            //  txtmail.Add(RecPurchaseSetup."Mail CG");
            // Message(RecPurchaseSetup."Mail DG");
            // Message(RecPurchaseSetup."Mail DG2");
            //Message(RecPurchaseSetup."Mail CG");
            repeat
                if i > 0 then
                    Clear(txtmail);

                I := I + 1;
                txtmail.Add(RecUserad."E-Mail");


                //  Message(RecUserAd."E-Mail");
                // Message('Sender : ' + RecUSERid."User ID");
                // Message('Receiver To : ' + format(txtmail.Get(1)));
                //IF RecUser."E-Mail" <> '' THEN BEGIN
                IF RecUserAd."E-Mail" <> '' THEN BEGIN

                    mymail.Create(RecUserAd."E-Mail", STRSUBSTNO(COMPANYNAME + ' : ' + 'Demande d''achat à traiter  %1', PurchReq."No."), BodyText, TRUE);
                    //   if RecPurchaseSetup."management controlleractivated" then begin
                    if RecUserController.Get(RecPurchaseSetup."management controller 1") then begin
                        if RecUserController."E-Mail" <> '' then
                            mymail.AddRecipient(RecipientType::Cc, RecUserController."E-Mail");
                    end;
                    if RecUserController.Get(RecPurchaseSetup."management controller 2") then begin
                        if RecUserController."E-Mail" <> '' then
                            mymail.AddRecipient(RecipientType::Cc, RecUserController."E-Mail");
                    end;
                    //  end;
                    mymail.AppendToBody('<table border="1" style="border: 1px Solid Black;text-align: center;" >');
                    mymail.AppendToBody('<tr>');
                    mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:200px" >%1</td>', 'N° Projet'));
                    mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:200px" >%1</td>', 'N° tâche Projet'));
                    mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:200px" >%1</td>', 'Demandeur'));

                    mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:250px" >%1</td>', 'N° Article'));
                    mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:250px" >%1</td>', 'Description'));
                    mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:200px" >%1</td>', 'Quantité'));

                    mymail.AppendToBody('</tr>');

                    ReclPrchLine.Reset();
                    ReclPrchLine.SetRange("Document No.", PurchReq."No.");

                    if ReclPrchLine.FindFirst() then begin

                        repeat
                            //  if ReclPrchLine."Ligne Status" <> ReclPrchLine."Ligne Status"::Refused then begin
                            //    ReclAxeactivite.Reset();
                            //  ReclAxeactivite.SetRange(Code, ReclPrchLine."Shortcut Dimension 1 Code");
                            // IF ReclAxeactivite.FindFirst() THEN;
                            //RecUserName.Get(ReclPrchLine."Request User ID");
                            mymail.AppendToBody('<tr>');
                            mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:200px" >%1</td>', ReclPrchLine."Job No."));
                            mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:200px" >%1</td>', ReclPrchLine."Job Task No."));
                            mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:200px" >%1</td>', pUserID));
                            mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:250px">%1</td>', ReclPrchLine."No."));
                            mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:250px">%1</td>', ReclPrchLine.Description));
                            mymail.AppendToBody(STRSUBSTNO('<td style="border: 1px Solid Black;text-align: center;width:200px">%1</td>', ReclPrchLine.Quantity));


                            mymail.AppendToBody('</tr>');
                        //end;

                        until ReclPrchLine.Next() = 0;
                    END;
                    mymail.AppendToBody('</table>');

                    mymail.AppendToBody(StrSubstNo('<a href=' + Url1 + '>Interne :  Lien demande  d''achat  </a><P>'));


                    mymail.AppendToBody(StrSubstNo('<a href=' + txturlEXt + '>Externe :  Lien demande d''achat  </a>'));



                    //   mymail.AppendToBody(Url1);
                    mymail.AppendToBody(FORMAT(cr));
                    mymail.AppendToBody('cordialement.');
                END
                ELSE
                    ERROR(Err03, RecUser."E-Mail");
                //   MESSAGE('%1-%2', RecUser."E-Mail", RecUserAd."E-Mail");



                EmailMessage.Send(mymail);

            until RecUserAd.Next() = 0;
        end;
        //>>Send  Email
    end;
    //HS
    var
        myInt: Integer;
}