Table 8001561 "Workflow Journal Line"
{
    //GL2024  ID dans Nav 2009 : "8004210"
    // //+WKF+ MB 10/01/07 déclenchement du pre trigger ID au lancement de l'operation suivante
    // //+WKF+ MB 12/09/06 si pas d'opération suivante alors cloture de la fiche
    // //+WKF+ MB 11/09/06 Positionnement sur l'operation suivante par defaut
    // //+WKF+ CW 03/08/02 New
    //         DL 17/10/05 Ajout clé -> Open
    //                     Ajout champ "Due Date"
    //         MB 24/08/06 Modification clé Open en Open,"Due Date"
    //            28/08/06 Vérification si opération open avant d'envoyer l'opération suivante

    Caption = 'Workflow Journal Line';
    //DrillDownPageID = 8004210;
    //LookupPageID = 8004210;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; Type; Integer)
        {
            Caption = 'Type';
            TableRelation = "Workflow Type";
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            Description = '#6330';
            TableRelation = IF (Type = CONST(21)) Customer."No." WHERE("No." = FIELD("No."))
            ELSE
            IF (Type = CONST(26)) Vendor."No." WHERE("No." = FIELD("No."))
            ELSE
            IF (Type = CONST(30)) Item."No." WHERE("No." = FIELD("No."))
            ELSE
            IF (Type = CONST(76)) Resource."No." WHERE("No." = FIELD("No."))
            ELSE
            IF (Type = CONST(5050)) Contact."No." WHERE("No." = FIELD("No."))
            ELSE
            IF (Type = CONST(5200)) Employee."No." WHERE("No." = FIELD("No."));
        }
        field(4; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(5; Subject; Text[50])
        {
            Caption = 'Subject';

            trigger OnValidate()
            begin
                IF Subject <> xRec.Subject THEN
                    TESTFIELD("Workflow Code", '');
            end;
        }
        field(6; "Workflow Code"; Code[10])
        {
            Caption = 'Workflow Code';
            TableRelation = "Workflow Procedure Header".Code WHERE("Workflow Type" = FIELD(Type));
        }
        field(7; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
        }
        field(8; "From Role"; Code[10])
        {
            Caption = 'From Role';
            TableRelation = "Workflow Role";
        }
        field(9; "From User ID"; Code[20])
        {
            Caption = 'From User ID';
            //GL2024 TableRelation = Login."User ID";
            TableRelation = "User Setup";

            trigger OnLookup()
            begin
                //  LoginManagement.LookupUserID("From User ID");
            end;

            trigger OnValidate()
            begin
                //LoginManagement.ValidateUserID("From User ID");
            end;
        }
        field(10; "Sent Date"; Date)
        {
            Caption = 'Sent Date';
        }
        field(11; "Sent Time"; Time)
        {
            Caption = 'Sent Time';
        }
        field(12; "To Role"; Code[10])
        {
            Caption = 'To Role';
            TableRelation = "Workflow Role";

            trigger OnValidate()
            var
                lCode: Code[20];
            begin
                lCode := "To Role";
                IF (xRec."To Role" <> '') AND ("To Role" <> xRec."To Role") THEN BEGIN
                    "To Role" := xRec."To Role";
                    TransferTo(lCode, '', "Due Date");
                END;
            end;
        }
        field(13; "To User ID"; Code[20])
        {
            Caption = 'To User ID';
            TableRelation = "Workflow Role - User"."User ID" WHERE("Role ID" = FIELD("To Role"));

            trigger OnValidate()
            var
                lCode: Code[20];
            begin
                //LoginManagement.ValidateUserID("From User ID");

                //#6510
                IF ("From User ID" <> UPPERCASE(USERID)) AND NOT WorkflowRoleUser.GET("To Role", USERID) THEN
                    ERROR(tRoleNotGranted, "To Role", USERID);
                //#6510//
                IF ("To Role" <> '') AND ("To User ID" <> '') AND NOT WorkflowRoleUser.GET("To Role", "To User ID") THEN
                    ERROR(tRoleNotGranted, "To Role", "To User ID");
                lCode := "To User ID";
                //IF (xRec."To User ID" <> '') AND ("To User ID" <> xRec."To User ID") THEN BEGIN
                IF ("To User ID" <> xRec."To User ID") THEN BEGIN
                    "To User ID" := xRec."To User ID";
                    TransferTo("To Role", lCode, "Due Date");
                END;
            end;
        }
        field(15; Open; Boolean)
        {
            Caption = 'Open';
        }
        field(16; Notification; Boolean)
        {
            Caption = 'Notification';
        }
        field(17; "Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Item Journal Template";
        }
        field(18; Comment; Boolean)
        {
            CalcFormula = Exist("Workflow Comment Line" WHERE("Journal Line No." = FIELD("Attached to Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            Editable = false;
            TableRelation = "Workflow Journal Line" WHERE(Type = FIELD(Type),
                                                           "No." = FIELD("No."),
                                                           "Workflow Code" = FIELD("Workflow Code"));
        }
        field(20; "Close Date"; Date)
        {
            Caption = 'Close Date';
        }
        field(21; "Close Time"; Time)
        {
            Caption = 'Close Time';
        }
        field(22; "Workflow Description"; Text[30])
        {
            CalcFormula = Lookup("Workflow Procedure Header".Description WHERE("Workflow Type" = FIELD(Type),
                                                                                Code = FIELD("Workflow Code")));
            Caption = 'Workflow Description';
            FieldClass = FlowField;
        }
        field(23; "Type Description"; Text[30])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(page),
                                                                           "Object ID" = FIELD(Type)));
            Caption = 'Type Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Due Date"; Date)
        {
            Caption = 'Due Date';

            trigger OnValidate()
            var
                lDueDate: Date;
            begin
                //#6510
                IF ("From User ID" <> UPPERCASE(USERID)) AND NOT WorkflowRoleUser.GET("To Role", USERID) THEN
                    ERROR(tRoleNotGranted, "To Role", USERID);
                //#6510//
                lDueDate := "Due Date";
                IF (xRec."Due Date" <> 0D) AND ("Due Date" <> xRec."Due Date") THEN BEGIN
                    "Due Date" := xRec."Due Date";
                    TransferTo("To Role", "To User ID", lDueDate);
                END;
            end;
        }
        field(201; Text1; Text[30])
        {
            CalcFormula = Lookup("Workflow Document".Text1 WHERE("Document Template" = FIELD(Type),
                                                                  "No." = FIELD("No.")));
            //CaptionClass = GetCaptionClass(FIELDNO(Text1));
            FieldClass = FlowField;
        }
        field(202; Text2; Text[30])
        {
            CalcFormula = Lookup("Workflow Document".Text2 WHERE("Document Template" = FIELD(Type),
                                                                  "No." = FIELD("No.")));
            //CaptionClass = GetCaptionClass(FIELDNO(Text2));
            FieldClass = FlowField;
        }
        field(301; Code1; Code[10])
        {
            CalcFormula = Lookup("Workflow Document".Code1 WHERE("Document Template" = FIELD(Type),
                                                                  "No." = FIELD("No.")));
            //CaptionClass = GetCaptionClass(FIELDNO(Code1));
            FieldClass = FlowField;
        }
        field(302; Code2; Code[10])
        {
            CalcFormula = Lookup("Workflow Document".Code2 WHERE("Document Template" = FIELD(Type),
                                                                  "No." = FIELD("No.")));
            //CaptionClass = GetCaptionClass(FIELDNO(Code2));
            FieldClass = FlowField;
        }
        field(401; Decimal1; Decimal)
        {
            //blankzero = true;
            CalcFormula = Lookup("Workflow Document".Decimal1 WHERE("Document Template" = FIELD(Type),
                                                                     "No." = FIELD("No.")));
            //CaptionClass = GetCaptionClass(FIELDNO(Decimal1));
            FieldClass = FlowField;
        }
        field(402; Decimal2; Decimal)
        {
            //blankzero = true;
            CalcFormula = Lookup("Workflow Document".Decimal2 WHERE("Document Template" = FIELD(Type),
                                                                     "No." = FIELD("No.")));
            //CaptionClass = GetCaptionClass(FIELDNO(Decimal2));
            FieldClass = FlowField;
        }
        field(501; Boolean1; Boolean)
        {
            CalcFormula = Lookup("Workflow Document".Boolean1 WHERE("Document Template" = FIELD(Type),
                                                                     "No." = FIELD("No.")));
            //CaptionClass = GetCaptionClass(FIELDNO(Boolean1));
            FieldClass = FlowField;
        }
        field(502; Boolean2; Boolean)
        {
            CalcFormula = Lookup("Workflow Document".Boolean2 WHERE("Document Template" = FIELD(Type),
                                                                     "No." = FIELD("No.")));
            //CaptionClass = GetCaptionClass(FIELDNO(Boolean2));
            FieldClass = FlowField;
        }
        field(601; Date1; Date)
        {
            CalcFormula = Lookup("Workflow Document".Date1 WHERE("Document Template" = FIELD(Type),
                                                                  "No." = FIELD("No.")));
            //CaptionClass = GetCaptionClass(FIELDNO(Date1));
            FieldClass = FlowField;
        }
        field(602; Date2; Date)
        {
            CalcFormula = Lookup("Workflow Document".Date2 WHERE("Document Template" = FIELD(Type),
                                                                  "No." = FIELD("No.")));
            //CaptionClass = GetCaptionClass(FIELDNO(Date2));
            FieldClass = FlowField;
        }
        field(701; Time1; Time)
        {
            CalcFormula = Lookup("Workflow Document".Time1 WHERE("Document Template" = FIELD(Type),
                                                                  "No." = FIELD("No.")));
            //CaptionClass = GetCaptionClass(FIELDNO(Time1));
            FieldClass = FlowField;
        }
        field(702; Time2; Time)
        {
            CalcFormula = Lookup("Workflow Document".Time2 WHERE("Document Template" = FIELD(Type),
                                                                  "No." = FIELD("No.")));
            //CaptionClass = GetCaptionClass(FIELDNO(Time2));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; Type, "No.")
        {
        }
        key(Key3; Type, "Workflow Code", Open)
        {
        }
        key(Key4; Open, "Due Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lComment: Record "Workflow Comment Line";
    begin
        lComment.SETRANGE("Journal Line No.", "Entry No.");
        lComment.DELETEALL;
    end;

    trigger OnInsert()
    var
        lWorkflowJnlLine: Record "Workflow Journal Line";
        lRole: Record "Workflow Role";
        lSession: Record Session;
    //  lWorkFlowMailNotify: Codeunit "WorkFlow Mail Notification";
    begin
        "Entry No." := 0;
        "From User ID" := USERID;
        Open := TRUE;
        "Sent Date" := TODAY;
        "Sent Time" := TIME;
        "Close Date" := 0D;
        "Close Time" := 0T;
        //3520
        //IF "Attached to Line No." = 0 THEN
        //  "Attached to Line No." := "Entry No.";
        //3520//
        Name := WorkflowNo.GetName(Type, "Template Name", "No.");
        IF ("To Role" <> '') AND ("To User ID" = '') THEN
            IF lRole.GET("To Role") AND (lRole."Main User ID" <> '') THEN BEGIN
                //#5792    lSession.SETRANGE("User ID",lRole."Main User ID");
                //#5632
                IF NOT Notification THEN
                    "To User ID" := lRole."Main User ID";
                /*DELETE
                //#5792
                    IF lSession.ISEMPTY AND NOT Notification AND lRole."Notify Other Users" THEN
                      lWkfMgt.Notify(Type,"No.",'',"To Role","Workflow Code");
                //#5792//
                DELETE*/
                //    IF lSession.FIND('-') THEN
                //      "To User ID" := lRole."Main User ID";
                //#5632
            END;

    end;

    trigger OnModify()
    var
    //  lWorkFlowMailNotify: Codeunit "WorkFlow Mail Notification";
    begin
        TESTFIELD(Open, TRUE);
    end;

    var
        tRoleNotGranted: Label 'Role %1 not granted to %2';
        tAlreadyUsed: Label 'This document is already used by %1.\Do you want to use it to?';
        WorkflowNo: Codeunit "Workflow No.";
        WorkflowRoleUser: Record "Workflow Role - User";
        tCloseAlreadyUsed: Label 'This document is already used by %1.\Do you want to close this line?';
        tConfirmTrigger: Label 'Confirm action below:\  %1';
        tNoLineSelected: Label 'No line selected';
        LoginManagement: Codeunit "User Management";
        Template: Record "Workflow Document Template";


    procedure Show()
    var
        lWorkflowJnlLine: Record "Workflow Journal Line";
    begin
        IF "Entry No." = 0 THEN
            ERROR(tNoLineSelected);
        lWorkflowJnlLine := Rec;
        //3586
        /*IF NOT AlreadyUsed(lWorkflowJnlLine) THEN BEGIN
          "Used By" := USERID;
          MODIFY;
          COMMIT; // Because ShowCard can call RunModal
        END ELSE IF NOT CONFIRM(tAlreadyUsed,FALSE,lWorkflowJnlLine."Used By") THEN
          EXIT;
        */
        //3586//

        WorkflowNo.ShowCard(Type, "Template Name", "No.");

        //3586
        /*IF "Used By" = USERID THEN BEGIN
          "Used By" := '';
          MODIFY;
        END;
        */
        //3586//

    end;


    procedure NextOperation(var pRec: Record "Workflow Journal Line")
    var
        lCurrJnlLine: Record "Workflow Journal Line";
        lNextJnlLine: Record "Workflow Journal Line";
        lPrevJnlLine: Record "Workflow Journal Line";
        lProcedureLine: Record "Workflow Procedure Line";
        lNextProcedureLine: Record "Workflow Procedure Line";
        lPos: Integer;
        lOK: Boolean;
        lProcedureLine2: Record "Workflow Procedure Line";
        lJnlLine: Record "Workflow Journal Line";
        lToUserID: Code[20];
    begin
        //+WKF+
        TESTFIELD(Open);
        //+WKF+//
        lCurrJnlLine := pRec;
        //#3586
        /*IF AlreadyUsed(lCurrJnlLine) THEN
          IF NOT CONFIRM(tCloseAlreadyUsed,FALSE,lCurrJnlLine."Used By") THEN
            EXIT;
        */
        //#3586//
        IF ("To Role" <> '') AND NOT WorkflowRoleUser.GET("To Role", USERID)
           AND ("To User ID" <> USERID) THEN
            ERROR(tRoleNotGranted, "To Role", USERID);

        lNextJnlLine.COPY(lCurrJnlLine);
        lNextJnlLine."Entry No." := 0;
        //DYS PAGE ADDON NON MIGRER
        // IF lProcedureLine.GET(Type, "Workflow Code", lCurrJnlLine."Operation No.") THEN
        //     IF lProcedureLine."Next Operation No." <> '' THEN BEGIN
        //         lPos := STRPOS(lProcedureLine."Next Operation No.", '|');
        //         IF lPos <> 0 THEN BEGIN
        //             lProcedureLine2.FILTERGROUP(10);
        //             lProcedureLine2.SETRANGE("Workflow Type", lProcedureLine."Workflow Type");
        //             lProcedureLine2.SETRANGE("Workflow Code", lProcedureLine."Workflow Code");
        //             lProcedureLine2.SETFILTER("Operation No.", lProcedureLine."Next Operation No.");
        //             lProcedureLine2.FILTERGROUP(0);
        //             //+WKF+
        //             IF lProcedureLine2.GET(lProcedureLine."Workflow Type",
        //             lProcedureLine."Workflow Code", lProcedureLine."Default Next Operation No.") THEN;
        //             //+WKF+//
        //             IF (page.RUNMODAL(page::"Workflow Procedure Line", lProcedureLine2) = ACTION::LookupOK) THEN BEGIN
        //                 lNextJnlLine."Operation No." := lProcedureLine2."Operation No.";
        //                 //IF lNextJnlLine."Operation No." < lProcedureLine."Operation No." THEN BEGIN
        //                 lJnlLine.SETCURRENTKEY(Type, "No.");
        //                 lJnlLine.SETRANGE(Type, lCurrJnlLine.Type);
        //                 lJnlLine.SETRANGE("No.", lCurrJnlLine."No.");
        //                 //#7132
        //                 lJnlLine.SETRANGE("Workflow Code", lCurrJnlLine."Workflow Code");
        //                 //#7132//
        //                 lJnlLine.SETRANGE("Operation No.", lNextJnlLine."Operation No.");
        //                 IF lJnlLine.FINDLAST THEN
        //                     lToUserID := lJnlLine."To User ID";
        //             END ELSE
        //                 ERROR('');
        //         END ELSE BEGIN
        //             lNextJnlLine."Operation No." := lProcedureLine."Next Operation No.";
        //             lProcedureLine."Next Operation No." := '';
        //         END;
        //         IF lNextProcedureLine.GET(Type, "Workflow Code", lNextJnlLine."Operation No.") THEN BEGIN
        //             lNextJnlLine."From Role" := "To Role";
        //             lNextJnlLine."Operation No." := lNextProcedureLine."Operation No.";
        //             lNextJnlLine."From User ID" := USERID;
        //             lNextJnlLine."To Role" := lNextProcedureLine."Role ID";
        //             lNextJnlLine."To User ID" := lToUserID;
        //             lNextJnlLine.Subject := lNextProcedureLine.Description;
        //             CODEUNIT.RUN(CODEUNIT::"Workflow Operation", lNextJnlLine);
        //         END;
        //     END;
        // Close(lCurrJnlLine);
        // //+WKF+
        // IF (lNextProcedureLine."Pre Trigger ID" <> 0) THEN
        //     WorkflowNo.Trigger(lNextJnlLine, lNextProcedureLine."Pre Trigger ID");
        //+WKF+
        //3586
        /*IF "Used By" = USERID THEN BEGIN
          "Used By" := '';
          MODIFY;
        END;
        */
        //3586

    end;


    procedure AlreadyUsed(var pWorkflowJnlLine: Record "Workflow Journal Line"): Boolean
    begin
        pWorkflowJnlLine.SETCURRENTKEY(Type, "No.");
        pWorkflowJnlLine.SETRANGE(Type, Type);
        pWorkflowJnlLine.SETRANGE("No.", "No.");
        pWorkflowJnlLine.SETRANGE(Open, TRUE);
        //3586 pWorkflowJnlLine.SETFILTER("Used By",'<>%1&<>''''',USERID);
        EXIT(pWorkflowJnlLine.FINDFIRST);
    end;


    procedure Close(pRec: Record "Workflow Journal Line"): Boolean
    var
        lProcedureLine: Record "Workflow Procedure Line";
        lPrevJnlLine: Record "Workflow Journal Line";
        lJnlLine: Record "Workflow Journal Line";
    begin
        //#5711
        /*
        IF lProcedureLine.GET(Type,"Workflow Code",pRec."Operation No.") AND
           (lProcedureLine."Trigger ID" <> 0) THEN BEGIN
          IF lProcedureLine."Confirmation Message" <> '' THEN
            IF NOT CONFIRM(tConfirmTrigger,FALSE,lProcedureLine."Confirmation Message") THEN
              ERROR('');
              //EXIT;
          WorkflowNo.Trigger(pRec,lProcedureLine."Trigger ID");
        END;
        */
        IF lProcedureLine.GET(Type, "Workflow Code", pRec."Operation No.") THEN BEGIN
            IF lProcedureLine."Confirmation Message" <> '' THEN
                IF NOT CONFIRM(tConfirmTrigger, FALSE, lProcedureLine."Confirmation Message") THEN
                    ERROR('');
            //DYS PAGE ADDON NON MIGRER
            // IF lProcedureLine."Trigger ID" <> 0 THEN
            //     WorkflowNo.Trigger(pRec, lProcedureLine."Trigger ID");
        END;
        //#5711//
        pRec."Close Date" := TODAY;
        pRec."Close Time" := TIME;
        pRec.Open := FALSE;
        pRec."To User ID" := USERID;
        pRec.MODIFY;
        IF lProcedureLine.Notify THEN BEGIN
            lPrevJnlLine.RESET;
            lPrevJnlLine.SETCURRENTKEY(Type, "No.");
            lPrevJnlLine.SETRANGE(Type, pRec.Type);
            lPrevJnlLine.SETRANGE("No.", pRec."No.");
            IF lPrevJnlLine.FINDFIRST THEN BEGIN // Notify First "From User ID"
                lJnlLine.COPY(pRec);
                lJnlLine."From Role" := pRec."To Role";
                lJnlLine."From User ID" := USERID;
                lJnlLine."To Role" := lPrevJnlLine."From Role";
                lJnlLine."To User ID" := lPrevJnlLine."From User ID";
                lJnlLine.Notification := TRUE;
                //DYS CDU ADDON NON MIGRER
                // IF lJnlLine."To User ID" <> USERID THEN
                //     CODEUNIT.RUN(CODEUNIT::"Workflow Operation", lJnlLine);
            END;
        END;
        EXIT(TRUE);

    end;


    procedure TransferTo(pRole: Code[10]; pUserID: Code[20]; pDueDate: Date)
    var
        lRec: Record "Workflow Journal Line";
        lPrevJnlLine: Record "Workflow Journal Line";
    //  lWorkFlowMailNotify: Codeunit "WorkFlow Mail Notification";
    begin
        //#7131
        TESTFIELD(Open, TRUE);
        //#7131//
        lRec := Rec;
        "Close Date" := TODAY;
        "Close Time" := TIME;
        Open := FALSE;
        MODIFY;

        //#6510 lRec."From Role" := "To Role";
        lRec."To Role" := pRole;
        lRec."From User ID" := USERID;
        lRec."To User ID" := pUserID;
        lRec."Due Date" := pDueDate;
        lRec.Open := TRUE;
        //3586 lRec."Used By" := '';
        lRec."Attached to Line No." := "Attached to Line No.";
        //DYS CDU ADDON NON MIGRER
        //CODEUNIT.RUN(CODEUNIT::"Workflow Operation", lRec);

        //WKF-MAIL
        //DYS CDU ADDON NON MIGRER
        //lWorkFlowMailNotify.SendMail(lRec);
        //WKF-MAIL//

        //3586
        /*IF "Used By" = USERID THEN BEGIN
          "Used By" := '';
          MODIFY;
        END;
        */
        //3586//
        Rec := xRec;

    end;

    local procedure GetCaptionClass(pFieldNo: Integer): Text[80]
    begin
        FILTERGROUP(2); // FormView
        IF HASFILTER THEN
            Type := GETRANGEMIN(Type);
        FILTERGROUP(0);
        IF (Type = 0) AND NOT Template.GET(Type) THEN
            EXIT('8001400,' + GetFieldCaption(pFieldNo))
        ELSE
            WITH Template DO CASE pFieldNo OF
                                 101:
                                     EXIT('8001400,' + Integer1);
                                 102:
                                     EXIT('8001400,' + Integer2);
                                 201:
                                     EXIT('8001400,' + Text1);
                                 202:
                                     EXIT('8001400,' + Text2);
                                 301:
                                     EXIT('8001400,' + Code1);
                                 302:
                                     EXIT('8001400,' + Code2);
                                 401:
                                     EXIT('8001400,' + Decimal1);
                                 402:
                                     EXIT('8001400,' + Decimal2);
                                 501:
                                     EXIT('8001400,' + Boolean1);
                                 502:
                                     EXIT('8001400,' + Boolean2);
                                 601:
                                     EXIT('8001400,' + Date1);
                                 602:
                                     EXIT('8001400,' + Date2);
                                 701:
                                     EXIT('8001400,' + Time1);
                                 702:
                                     EXIT('8001400,' + Time2);
                                 ELSE
                                     EXIT('CaptionClass ' + GetFieldCaption(pFieldNo));
                END;
    end;

    local procedure GetFieldCaption(FieldNo: Integer): Text[100]
    var
        "Field": Record Field;
    begin
        Field.GET(DATABASE::"Workflow Document", FieldNo);
        EXIT(Field."Field Caption");
    end;
}

