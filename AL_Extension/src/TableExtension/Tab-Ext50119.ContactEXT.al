TableExtension 50119 ContactEXT extends Contact
{
    //Description =#8382;
    DrillDownpageID = "Contact Card";
    fields
    {
        modify("No. of Business Relations")
        {
            Description = 'Modification CalcFormula';
        }

        modify("Trade Register")
        {

            Caption = 'Commercial Register';
        }
        modify("Stock Capital")
        {

            Caption = 'Authorized Capital';
        }

        modify("Salesperson Code")
        {
            trigger OnAfterValidate()
            var
                lOpp: Record Opportunity;
                lToDo: Record "To-do";
                lTodo2: Record "To-do";
                lAttendee: Record Attendee;
                lTotalRecordsNumber: Integer;
                lCounter: Integer;
                lWindow: Dialog;
                lStartTime: Time;
                lEndTime: Time;
                lInteractionLogEntry: Record "Interaction Log Entry";
                ltChange: label 'Do you want to change %1 on the related open Opportunitiess and To-dos with the same %1?';
                ltProcess: label 'Current process @1@@@@@@@@@@@@@@@\';
                ltStatus: label 'Current status  #2###############';
                ltToDo: label 'Updating To-dos';
                ltOpportunity: label 'Updating Opportunities';
                lTextInteraction: label 'Updating Interactions';

            begin


                //+REF+CRM
                IF ("Salesperson Code" <> xRec."Salesperson Code") AND
                   (xRec."Salesperson Code" <> '') AND
                   ("No." <> '') THEN BEGIN
                    lOpp.RESET;
                    lOpp.SETCURRENTKEY("Contact Company No.", "Contact No.", Closed);
                    lOpp.SETRANGE("Contact No.", "No.");
                    lOpp.SETRANGE(Closed, FALSE);
                    lOpp.SETRANGE("Salesperson Code", xRec."Salesperson Code");
                    lToDo.RESET;
                    lToDo.SETCURRENTKEY("Contact Company No.", Date, "Contact No.", Closed);
                    lToDo.SETRANGE("Contact No.", "No.");
                    lToDo.SETRANGE(Closed, FALSE);
                    lToDo.SETRANGE("Salesperson Code", xRec."Salesperson Code");
                    lToDo.SETRANGE("Opportunity No.", '');
                    //#8436
                    lInteractionLogEntry.RESET;
                    lInteractionLogEntry.SETCURRENTKEY("Contact Company No.", "Contact No.", Date, Postponed);
                    lInteractionLogEntry.SETRANGE(Postponed, TRUE);
                    lInteractionLogEntry.SETRANGE("Contact No.", "No.");
                    lInteractionLogEntry.SETRANGE("Salesperson Code", xRec."Salesperson Code");
                    //#8436

                    //#8436
                    //  IF NOT lOpp.ISEMPTY OR NOT lToDo.ISEMPTY THEN
                    IF NOT lOpp.ISEMPTY OR NOT lToDo.ISEMPTY OR NOT lInteractionLogEntry.ISEMPTY THEN
                        //#8436//
                        IF CONFIRM(ltChange, FALSE, FIELDCAPTION("Salesperson Code")) THEN BEGIN
                            //Opportunités
                            IF NOT lOpp.ISEMPTY THEN BEGIN
                                lTotalRecordsNumber := lOpp.COUNT;
                                lCounter := 0;
                                lOpp.FINDFIRST;
                                lWindow.OPEN(ltProcess + ltStatus);
                                lWindow.UPDATE(2, ltOpportunity);
                                REPEAT
                                    lCounter := lCounter + 1;
                                    lWindow.UPDATE(1, ROUND(lCounter / lTotalRecordsNumber * 10000, 1));
                                    lOpp.wSetHideMessages(TRUE);
                                    lOpp.VALIDATE("Salesperson Code", "Salesperson Code");
                                UNTIL lOpp.NEXT = 0;
                                lOpp.wSetHideMessages(FALSE);
                                lWindow.CLOSE;
                            END;
                            //#8436
                            // Interactions reportées
                            //Opportunités
                            IF NOT lInteractionLogEntry.ISEMPTY THEN BEGIN
                                lTotalRecordsNumber := lInteractionLogEntry.COUNT;
                                lCounter := 0;
                                lInteractionLogEntry.FINDFIRST;
                                lWindow.OPEN(ltProcess + ltStatus);
                                lWindow.UPDATE(2, lTextInteraction);
                                REPEAT
                                    lCounter := lCounter + 1;
                                    lWindow.UPDATE(1, ROUND(lCounter / lTotalRecordsNumber * 10000, 1));
                                    lInteractionLogEntry.VALIDATE("Salesperson Code", "Salesperson Code");
                                    lInteractionLogEntry.MODIFY;
                                UNTIL lOpp.NEXT = 0;
                                lWindow.CLOSE;
                            END;
                            //#8436
                            //Actions
                            IF NOT lToDo.ISEMPTY THEN BEGIN
                                lTotalRecordsNumber := lToDo.COUNT;
                                lCounter := 0;
                                lToDo.FINDFIRST;
                                lWindow.OPEN(ltProcess + ltStatus);
                                lWindow.UPDATE(2, ltToDo);
                                lStartTime := TIME;
                                REPEAT
                                    lCounter := lCounter + 1;
                                    lWindow.UPDATE(1, ROUND(lCounter / lTotalRecordsNumber * 10000, 1));

                                    IF lToDo.Type = lToDo.Type::Meeting THEN BEGIN
                                        //Procedure standard dans nav2009 n'existe pas dans bc2024   lToDo.GetMeetingOrganizerTodo(lTodo2);
                                        IF lToDo."Salesperson Code" <> lTodo2."Salesperson Code" THEN BEGIN
                                            lToDo.VALIDATE("Salesperson Code", "Salesperson Code");
                                            lToDo.MODIFY;
                                        END;
                                        lAttendee.RESET;
                                        lAttendee.SETRANGE("To-do No.", lTodo2."No.");
                                        lAttendee.SETRANGE("Attendee No.", xRec."Salesperson Code");
                                        lAttendee.SETRANGE("Attendee Type", lAttendee."Attendee Type"::Salesperson);
                                        lAttendee.SETRANGE("Attendance Type", lAttendee."Attendance Type"::Required, lAttendee."Attendance Type"::Optional);
                                        IF lAttendee.FIND('-') THEN BEGIN
                                            /*{OUTLOOK-SYNC
                                                                           VARIABLE Local = lOLAppMgmt Codeunit 5072
                                                          lOLAppMgmt.SetAttendeeUpdating(TRUE);
                                                                                        lOLAppMgmt.SetAttendee(lAttendee);
                                                                                        OUTLOOK-SYNC}*/
                                            lAttendee.VALIDATE("Attendee No.", "Salesperson Code");
                                            lAttendee.MODIFY(TRUE);
                                            //OUTLOOK-SYNC              lOLAppMgmt.SetAttendeeUpdating(FALSE);
                                        END;
                                    END ELSE BEGIN
                                        lToDo.VALIDATE("Salesperson Code", "Salesperson Code");
                                        lToDo.MODIFY(TRUE);
                                    END;
                                UNTIL lToDo.NEXT = 0;
                                lEndTime := TIME;
                                lWindow.CLOSE;
                                /*{OUTLOOK-SYNC
                                                        lOLAppMgmt.SetAttendeeUpdating(TRUE);
                                                    IF lOLAppMgmt.SynchronizationEnabled THEN
                                                        IF lOLAppMgmt.IsOLServerValid THEN
                                                            lOLAppMgmt.CheckForConflicts(lStartTime, lEndTime);
                                                    lOLAppMgmt.SetAttendeeUpdating(FALSE);
                                                    OUTLOOK-SYNC}*/
                            END;

                        END;
                END;
                //+REF+CRM//
            end;
        }

        modify("E-Mail")
        {
            trigger OnAfterValidate()
            begin
                IF "E-Mail" <> xRec."E-Mail" THEN
                    "E-Mail 2" := "E-Mail";
            end;
        }

        field(57500; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
        field(8001400; "Sell-to Customer Template Code"; Code[10])
        {
            Caption = 'Sell-to Customer Template Code';
            TableRelation = "Customer Templ.";

            trigger OnValidate()
            var
            //  SellToCustTemplate: Record 5105;
            begin
            end;
        }
        field(8001401; "Business Relation Filter"; Code[10])
        {
            Caption = 'Business Relation Filter';
            FieldClass = FlowFilter;
            TableRelation = "Business Relation";
        }
        field(8001484; "User Favorite Filter"; Code[20])
        {
            Caption = 'User Favorite Filter';
            FieldClass = FlowFilter;
        }
        field(8001485; Favorite; Boolean)
        {
            CalcFormula = exist("Filter Favorite" where("User ID" = field("User Favorite Filter"),
                                                         "Table ID" = const(5050),
                                                         "Source Type" = const(0),
                                                         "No." = field("No.")));
            Caption = 'Favorite';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {

        key(STG_Key17; "Company Name", "Company No.", Type, "Search Name")
        {
        }
        key(STG_Key18; Synchronise)
        {
        }
    }



    trigger OnBeforeInsert()
    begin
        //+REF+TEMPLATE
        IF ("No." = '') AND ("No. Series" <> '') THEN
            NoSeriesMgt.InitSeries("No. Series", "No. Series", 0D, "No.", "No. Series");
        //+REF+TEMPLATE//
    end;

    trigger OnAfterInsert()
    begin
        //#7970
        //#7807 TypeChange;
        // TypeChange     //#7970//
        //+REF+FILTER
        SETRANGE("User Favorite Filter", USERID);
        //+REF+FILTER//

        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnInsert(wReplicationRef);
        //+REF+REPLIC//
    end;


    trigger OnAfterModify()
    VAR
        lReplicationRef: RecordRef;
    begin
        //#7970
        //#7807
        //TypeChange;
        //#7807//
        //"7970//
        //+REF+REPLIC
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnModify(wReplicationRef, lReplicationRef);
        //+REF+REPLIC//

    end;

    trigger OnAfterDelete()
    var
        lCharact: Record Characteristic;
    begin
        //+REF+CHARACT
        lCharact.SETRANGE("Table Name", lCharact."Table Name"::Contact);
        lCharact.SETRANGE("No.", "No.");
        lCharact.DELETEALL;
        //+REF+CHARACT//

        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnDelete(wReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnAfterRename()
    var
        lReplicationRef: RecordRef;
    begin
        //+REF+REPLIC
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnRename(lReplicationRef, wReplicationRef);
        //+REF+REPLIC//
    end;


    procedure fSearchName(pRec: Record Contact): Text[30]
    var
        lNewName250: Text[250];
    begin
        //+REF+SEARCHNAME
        with pRec do
            if Type = Type::Company then
                exit(UpperCase(Name))
            else begin
                if Surname <> '' then
                    lNewName250 := lNewName250 + ' ' + Surname;
                if "First Name" <> '' then
                    lNewName250 := lNewName250 + ' ' + "First Name";
                if "Middle Name" <> '' then
                    lNewName250 := lNewName250 + ' ' + "Middle Name";
                lNewName250 := DelChr(lNewName250, '<', ' ');
                exit(UpperCase(CopyStr(lNewName250, 1, MaxStrLen("Search Name"))));
            end;
        //+REF+SEARCHNAME//
    end;

    procedure fShowCard()
    begin
        page.RunModal(page::"Contact Card", Rec);
    end;

    procedure gShowOppStatistics()
    begin
        page.RunModal(page::"Contact Statistics", Rec);
    end;

    procedure gShowIntLogEntries(pPostponed: Boolean)
    var
        lInteractionlogEntry: Record "Interaction Log Entry";
    begin
        lInteractionlogEntry.SetCurrentkey("Contact No.");
        lInteractionlogEntry.SetRange("Contact No.", "No.");
        lInteractionlogEntry.SetRange(Postponed, pPostponed);
        page.RunModal(page::"Interaction Log Entries", lInteractionlogEntry);
    end;

    procedure fShowToDoList()
    var
        lToDo: Record "To-do";
    begin
        lToDo.SetCurrentkey("Contact Company No.", "Contact No.");
        lToDo.SetRange("Contact Company No.", "Company No.");
        lToDo.SetRange("Contact No.", "No.");
        page.RunModal(page::"Task List", lToDo);
    end;

    procedure fShowComment()
    var
        lRlshpMgtCommentLine: Record "Rlshp. Mgt. Comment Line";
    begin
        lRlshpMgtCommentLine."Table Name" := lRlshpMgtCommentLine."table name"::Contact;
        lRlshpMgtCommentLine."No." := "No.";
        lRlshpMgtCommentLine.SetRange("Table Name", lRlshpMgtCommentLine."table name"::Contact);
        lRlshpMgtCommentLine.SetRange("No.", "No.");
        lRlshpMgtCommentLine.SetRange("Sub No.", 0);
        page.RunModal(page::"Rlshp. Mgt. Comment Sheet", lRlshpMgtCommentLine);
    end;

    var
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
        TextChange: label 'Do you want to change %1 on the related open Opportunitiess, To-dos and Posteponed interaction with the same %1?';
        TextTraitement: label 'Current process @1@@@@@@@@@@@@@@@\';
        TextStatut: label 'Current status  #2###############';
        TextToDo: label 'Updating To-dos';
        TextOpp: label 'Updating Opportunities';
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

