Codeunit 8001493 "OutlookLink ContactManagement"
{
    // //+REF+OUTLOOK CW 04/05/11


    trigger OnRun()
    begin
        // Used to get OutlookItem with EntryID to avoid an error if not exists :
        //  TryCatch.Set(OutlookNameSpace,OutlookMapiFolder,"Outlook EntryID");
        //  IF TryCatch.RUN then
        //    TryCatch.Get(ContactItem);
        //GL2024 Automation non compatible  OutlookContactItem := OutlookNameSpace.GetItemFromID(OutlookEntryID, OutlookMapiFolder.StoreID);
    end;

    var
        OutlookContactMapping: Codeunit "OutlookLink ContactMapping";
        //GL2024 Automation non compatible    OutlookInitialized: Boolean;
        //GL2024 Automation non compatible  OutlookApplication: Automation;
        //GL2024 Automation non compatible   OutlookNameSpace: Automation;
        //GL2024 Automation non compatible     OutlookMapiFolder: Automation;
        //GL2024 Automation non compatible    OutlookItems: Automation;
        //GL2024 Automation non compatible    OutlookContactItem: Automation;
        OutlookEntryID: Text[140];


    /*  //GL2024 Automation non compatible procedure Set(var pNameSpace: Automation; var pMapiFolder: Automation; var pEntryID: Text[250]): Boolean
      begin
          OutlookNameSpace := pNameSpace;
          OutlookMapiFolder := pMapiFolder;
          OutlookEntryID := pEntryID;
      end;


      procedure Get(var pContactItem: Automation): Boolean
      begin
          pContactItem := OutlookContactItem;
      end;
  */

    procedure DisplayContact(pContact: Record Contact)
    var
        lOutlookLink: Record OutlookLink;
        lExists: Boolean;
        ltDeleted: label 'This card doesn''t exists anymore as an Outlook contact';
    begin
        //GL2024 Automation non compatible    if not OutlookInitialized then
        //GL2024 Automation non compatible    Initialize;

        lOutlookLink."Table ID" := Database::Contact;
        lExists := lOutlookLink.Exists(0, pContact."No.");

        if lExists and (lOutlookLink."Outlook EntryID" <> '') then begin
            if not lOutlookLink.OutlookCard then begin
                lOutlookLink."Outlook EntryID" := '';
                lOutlookLink.Modify(true);
            end;
        end;
        /* //GL2024 Automation non compatible else begin
            OutlookContactItem := OutlookApplication.CreateItem(2); // 2:Contact
            OutlookContactMapping.NavToOutlook(pContact, OutlookContactItem);
            OutlookApplication.ActiveWindow;
            OutlookContactItem.Display(true);
            if OutlookContactItem.EntryID = '' then begin
            end // ?? Suite résolution doublon dans Outlook, "EntryID" reste vide ??
            else
                if lExists then begin
                    lOutlookLink."Outlook EntryID" := OutlookContactItem.EntryID;
                    lOutlookLink.Modify(true);
                end else
                    lOutlookLink.AddContact(pContact, OutlookContactItem.EntryID);
        end;*/
    end;


    procedure Display(pOutlookEntryID: Text[140]): Boolean
    var
        lTryCatch: Codeunit "OutlookLink ContactManagement";
    begin
        /* //GL2024 Automation non compatible  if not OutlookInitialized then
              Initialize;

          lTryCatch.Set(OutlookNameSpace, OutlookMapiFolder, pOutlookEntryID);
          if lTryCatch.Run then begin
              lTryCatch.Get(OutlookContactItem);
              OutlookApplication.ActiveWindow;
              OutlookContactItem.Display(true);
              exit(true);
          end;*/
    end;


    procedure SetOutlookSensitivity(var pOutlookLink: Record OutlookLink): Boolean
    var
        lTryCatch: Codeunit "OutlookLink ContactManagement";
    begin
        pOutlookLink.TestField("Outlook EntryID");
        /* //GL2024 Automation non compatible if not OutlookInitialized then
             Initialize;

         lTryCatch.Set(OutlookNameSpace, OutlookMapiFolder, pOutlookLink."Outlook EntryID");
         if lTryCatch.Run then begin
             lTryCatch.Get(OutlookContactItem);
             OutlookContactItem.Sensitivity := 2;
             OutlookContactItem.Save;
             pOutlookLink.Delete(true);
             exit(true);
         end;*/
    end;


    procedure AddFromOutlook()
    var
        i: Integer;
        lProgress: Dialog;
        //GL2024 Automation non compatible  lOutlookItems: Automation;
        //GL2024 Automation non compatible    lOutlookContactItem: Automation;
        lOutlookLink: Record OutlookLink;
        ltProgress: label '@1@@@@@@@@@@@@@@@@@@';
        lOutlookLinkContactMapping: Codeunit "OutlookLink ContactMapping";
        lContact: Record Contact;
        lOutlookLink2: Record OutlookLink;
    begin
        /*  if not OutlookInitialized then
              Initialize();*/

        with lOutlookLink do begin
            SetCurrentkey("User ID", "Table ID");
            SetRange("User ID", UserId);
            SetRange("Table ID", Database::Contact);
            "User ID" := UserId;
            "Table ID" := Database::Contact;
        end;
        lOutlookLink2.Copy(lOutlookLink);

        lProgress.Open(ltProgress);
        //GL2024 Automation non compatible   lOutlookItems := OutlookItems.Restrict('[Sensitivity] = 0 and [MessageClass] = "IPM.Contact"');
        /*  //GL2024 Automation non compatible  for i := 1 to lOutlookItems.Count do begin
               lProgress.Update(1, (i * 10000) DIV lOutlookItems.Count);
               lOutlookContactItem := lOutlookItems.Item(i);
               if not lOutlookLink.ExistsEntryID(lOutlookContactItem.EntryID) then begin
                   lOutlookLink.Init;
                   lOutlookLink."Line No." := 0; // AutoIncrement
                   lOutlookLink."Company Name" := CopyStr(lOutlookContactItem.CompanyName, 1, MaxStrLen(lOutlookLink."Company Name"));
                   with lOutlookContactItem do
                       lOutlookLink."Contact Name" := CopyStr(Last Name + ' ' + FirstName, 1, MaxStrLen(lOutlookLink."Contact Name"));
                   //    lOutlookLink."Contact Name" := COPYSTR(lOutlookContactItem.LastFirstSpaceOnly,1,MAXSTRLEN(lOutlookLink."Contact Name"));
                   if lOutlookContactItem.CompanyName <> '' then
                       lOutlookLink."Search Name" := lOutlookContactItem.CompanyName
                   else
                       lOutlookLink."Search Name" := lOutlookLink."Contact Name";
                   /*
                       WITH lOutlookContactItem DO
                         lOutlookLink."Contact Name" := COPYSTR(LastName + ' ' + FirstName,1,MAXSTRLEN(lOutlookLink."Company Name"));
                   */
        /* //GL2024 Automation non compatible    lOutlookLink."Outlook EntryID" := lOutlookContactItem.EntryID;
            Clear(lContact);
            if lOutlookLinkContactMapping.Match(lOutlookContactItem, lContact) then
                if not lOutlookLink2.Exists(0, lContact."No.") then
                    lOutlookLink."No." := lContact."No.";
            lOutlookLink.Insert(true);
        end;
    end;*/

    end;


    procedure Merge(var pRec: Record OutlookLink; var pMatch: Record OutlookLink)
    begin
        pRec.TestField(Linked, false);
        if (pRec."No." = '') and (pMatch."No." <> '') then begin
            pRec."No." := pMatch."No.";
            pRec.Modify(true);
            pMatch.Delete(true);
            Clear(pMatch);
        end else
            if (pRec."Outlook EntryID" = '') and (pMatch."Outlook EntryID" <> '') then begin
                pRec."Outlook EntryID" := pMatch."Outlook EntryID";
                pRec.Modify(true);
                pMatch.Delete(true);
                Clear(pMatch);
            end else
                pMatch.Copy(pRec);
    end;


    procedure Split(var pRec: Record OutlookLink)
    var
        lRec: Record OutlookLink;
    begin
        pRec.TestField(Linked, true);
        lRec.Copy(pRec);
        pRec."No." := '';
        pRec.Modify(true);
        lRec."Outlook EntryID" := '';
        lRec."Line No." := 0; // AutoIncrement
        lRec.Insert(true);
    end;


    procedure CreateFromOutlook(var pOutlookLink: Record OutlookLink): Boolean
    var
        lTryCatch: Codeunit "OutlookLink ContactManagement";
        lContact: Record Contact;
    begin
        pOutlookLink.TestField("No.", '');
        /* //GL2024 Automation non compatible if not OutlookInitialized then
             Initialize;

         lTryCatch.Set(OutlookNameSpace, OutlookMapiFolder, pOutlookLink."Outlook EntryID");
         if lTryCatch.Run then begin
             lTryCatch.Get(OutlookContactItem);

             OutlookContactMapping.OutlookToNav(OutlookContactItem, lContact);
             lContact.Insert(true);
             pOutlookLink."No." := lContact."No.";
             pOutlookLink.Modify(true);
             exit(true);
         end;*/
    end;


    procedure Synchronize()
    var
        lWindow: Dialog;
        lOutlookLink: Record OutlookLink;
        lContact: Record Contact;
        lCount: Integer;
        lProgress: Integer;
        lAction: action;
        ltProgress: label '@1@@@@@@@@@@@@@@@@@@';
        ltConfirm: label 'Do you want to send %1 contacts to Outlook?';
        ltCancel: label 'Synchronisation has been canceled but previous update has been commited.';
        lTryCatch: Codeunit "OutlookLink ContactManagement";
        lCancel: Boolean;
        lOutlookCompareBuffer: Record "OutlookLink Compare Buffer" temporary;
        lRecordRef: RecordRef;
        //GL2024 NAVIBAT   lCompareForm: Page 8001494;
        //GL2024 Automation non compatible    lDynamicsNavContactItem: Automation;
        ltCaption: label 'Update Outlook for %1 %2?';
    begin
        lOutlookLink.SetRange("User ID", UserId);
        lOutlookLink.SetRange("Table ID", Database::Contact);
        //lOutlookLink.SETRANGE(Linked,TRUE);
        //lCount := lOutlookLink.COUNT;
        //lOutlookLink.SETRANGE(Linked);
        lOutlookLink.SetFilter("No.", '<>%1', '');
        lOutlookLink.FindSet;
        if not Confirm(ltConfirm, true, lOutlookLink.Count, lCount) then
            exit;

        /* if not OutlookInitialized then
             Initialize;*/

        lCount := lOutlookLink.Count;
        lWindow.Open(ltProgress);

        repeat
            lProgress += 1;
            lWindow.Update(1, (lProgress * 10000) DIV lCount);
            if not lContact.Get(lOutlookLink."No.") then begin
                lOutlookLink."No." := '';
                lOutlookLink.Modify(true); // Orphan
                Commit;
            end else
                if lOutlookLink."Outlook EntryID" = '' then begin
                    //GL2024 Automation non compatible      OutlookContactItem := OutlookApplication.CreateItem(2); // 2:Contact
                    //GL2024 Automation non compatible     OutlookContactMapping.NavToOutlook(lContact, OutlookContactItem);
                    //GL2024 Automation non compatible    OutlookContactItem.Save;
                    //GL2024 Automation non compatible    lOutlookLink."Outlook EntryID" := OutlookContactItem.EntryID;
                    lOutlookLink.Modify(true);
                    Commit;
                end else begin
                    //GL2024 Automation non compatible  lTryCatch.Set(OutlookNameSpace, OutlookMapiFolder, lOutlookLink."Outlook EntryID");
                    if not lTryCatch.Run then begin
                        lOutlookLink."Outlook EntryID" := '';
                        lOutlookLink.Modify; // Should have a confirm dialog??
                        Commit;
                    end else begin
                        //GL2024 Automation non compatible  lTryCatch.Get(OutlookContactItem);
                        //GL2024 Automation non compatible      lDynamicsNavContactItem := OutlookApplication.CreateItem(2); // 2:Contact
                        //GL2024 Automation non compatible      OutlookContactMapping.NavToOutlook(lContact, lDynamicsNavContactItem);
                        lRecordRef.GetTable(lContact);
                        lOutlookCompareBuffer.Set(lRecordRef);
                        //GL2024 Automation non compatible  OutlookContactMapping.Compare(lContact, lDynamicsNavContactItem, OutlookContactItem, lOutlookCompareBuffer);
                        lOutlookCompareBuffer.SetRange(Changed, true);
                        if not lOutlookCompareBuffer.IsEmpty then begin
                            lWindow.Close;
                            //GL2024 NAVIBAT   lCompareForm.Caption := StrSubstNo(ltCaption, lContact.TableCaption, lContact."No.");
                            lOutlookCompareBuffer.SetRange(Changed);
                            //GL2024 NAVIBAT    lCompareForm.Initialize(lOutlookLink, lRecordRef, lOutlookCompareBuffer);

                            /*   //GL2024 NAVIBAT    case lComparePage.RunModal of
                                     Action::Yes:
                                         begin
                                             lRecordRef.SetTable(lContact);
                                             OutlookContactMapping.NavToOutlook(lContact, OutlookContactItem);
                                             OutlookContactItem.Save;
                                         end;
                                     /*
                                               ACTION::No:BEGIN
                                                 OutlookContactMapping.OutlookToNav(OutlookContactItem,lContact);
                                                 lContact.MODIFY(TRUE);
                                               END;
                                     */
                            /* Action::Cancel:
                                 lCancel := true;
                         end; // Case
                         Clear(lCompareForm);*/
                            if not lCancel then
                                lWindow.Open(ltProgress);
                        end;
                        lOutlookCompareBuffer.DeleteAll;
                    end;
                end;
        until (lOutlookLink.Next = 0) or lCancel;

        if lCancel then
            Message(ltCancel)
        else
            lWindow.Close();

    end;

    local procedure Initialize()
    begin
        /* //GL2024 Automation non compatible  if not OutlookInitialized then begin
              Create(OutlookApplication);
              OutlookNameSpace := OutlookApplication.GetNamespace('MAPI');
              OutlookMapiFolder := OutlookNameSpace.GetDefaultFolder(10); // 10:olFolderContacts
              OutlookItems := OutlookMapiFolder.Items;
              OutlookInitialized := true;
          end;*/
    end;
}

