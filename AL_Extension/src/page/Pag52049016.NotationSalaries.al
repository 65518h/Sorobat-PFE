page 52049016 "Notation Salaries"
{
    //GL2024  ID dans Nav 2009 : "39001544"
    DeleteAllowed = false;
    Description = 'InsertAllowed=No';
    PageType = List;
    SourceTable = Employee;
    ApplicationArea = all;
    UsageCategory = Lists;
    //DYS page non complier dans NAV
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(FiltreSupHearchic; FiltreSupHearchic)
                {
                    ApplicationArea = Basic;
                    Caption = 'N° supérieur hiérarchique';
                    Editable = false;
                    Lookup = false;

                    trigger OnValidate()
                    begin
                        FiltreSupHearchicOnAfterValida;
                    end;
                }
                field(NomSupHearchic; NomSupHearchic)
                {
                    ApplicationArea = Basic;
                    Caption = 'Manager No.';
                    Editable = false;
                    Lookup = false;
                }
                field(FiltreGrpComptaSalarie; FiltreGrpComptaSalarie)
                {
                    ApplicationArea = Basic;
                    Caption = 'Filtre grp. compta salarié';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                    //RecLGrpComptaSalarie:Record 70032;
                    begin
                        //GL2024
                        // IF PAGE.RUNMODAL(70064, RecLGrpComptaSalarie, RecLGrpComptaSalarie.Code) = ACTION::LookupOK THEN BEGIN
                        //     FiltreGrpComptaSalarie := RecLGrpComptaSalarie.Code;
                        //     rec.SETFILTER("Employee Posting Group", FiltreGrpComptaSalarie);
                        //     CurrPage.UPDATE;
                        // END;

                    end;

                    trigger OnValidate()
                    begin
                        Rec.SetFilter("Employee Posting Group", FiltreGrpComptaSalarie);
                        FiltreGrpComptaSalarieOnAfterV;
                    end;
                }
                field(FiltreSalarie; FiltreSalarie)
                {
                    ApplicationArea = Basic;
                    Caption = 'Filtre n° salarié';
                    TableRelation = Employee where("Relation de travail" = filter(Contractuel));

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        RecLSalarie: Record Employee;
                    begin
                        RecLSalarie.FilterGroup(2);
                        RecLSalarie.SetRange(RecLSalarie.Blocked, false);
                        RecLSalarie.SetRange(RecLSalarie."Relation de travail", RecLSalarie."relation de travail"::Contractuel);
                        RecLSalarie.FilterGroup(0);
                        RecLSalarie.SetFilter("Employee Posting Group", FiltreGrpComptaSalarie);

                        if page.RunModal(70129, RecLSalarie, RecLSalarie."No.") = Action::LookupOK then begin
                            FiltreSalarie := RecLSalarie."No.";
                            Rec.SetFilter("No.", FiltreSalarie);
                            CurrPage.Update;
                        end
                    end;

                    trigger OnValidate()
                    begin
                        Rec.SetFilter("No.", FiltreSalarie);
                        FiltreSalarieOnAfterValidate;
                    end;
                }
                field(WorkDate; WorkDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Date';
                }
                field(Mois; Mois)
                {
                    ApplicationArea = Basic;
                    Caption = 'Mois';
                }
                field(CodGNote; CodGNote)
                {
                    ApplicationArea = Basic;
                    Caption = 'Type Note';
                    TableRelation = "Paramétre Parc";

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //DYS
                        // IF PAGE.RUNMODAL(PAGE::"Notes Setup", RecLNoteSetup) = ACTION::LookupOK THEN
                        //     CodGNote := RecLNoteSetup.Code;
                        // RecGParamGRH.GET;
                        // CurrPage."Note Productivite".VISIBLE := (CodGNote <> RecGParamGRH."Code note prime") AND (CodGNote <> '');
                        // CurrPage."Note Securite".VISIBLE := (CodGNote <> RecGParamGRH."Code note prime") AND (CodGNote <> '');
                        // "Note PrimeVisible" := CodGNote = RecGParamGRH."Code note prime";

                        CurrPage.Update;

                    end;

                    trigger OnValidate()
                    begin
                        RecGParamGRH.Get;
                        //DYS
                        // CurrPage."Note Productivite".VISIBLE := (CodGNote <> RecGParamGRH."Code note prime") AND (CodGNote <> '');
                        // CurrPage."Note Securite".VISIBLE := (CodGNote <> RecGParamGRH."Code note prime") AND (CodGNote <> '');
                        // "Note PrimeVisible" := CodGNote = RecGParamGRH."Code note prime";
                        CodGNoteOnAfterValidate;
                    end;
                }
            }
            repeater(Control1120000)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                    DrillDown = false;
                    Editable = false;
                    Lookup = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            // group("&Valider...")
            // {
            //     Caption = '&Valider...';
            action(Valider2)
            {
                ApplicationArea = Basic;
                Caption = 'Valider';
                ShortCutKey = 'F9';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Valider;
                end;
            }
            // }
        }
    }

    trigger OnOpenPage()
    begin
        RecGEmployee.Reset;
        Rec.Reset;
        /*RecGEmployee.SETRANGE(RecGEmployee.USERID1,DATABASE.USERID);
        IF RecGEmployee.FINDFIRST THEN
        BEGIN
          FILTERGROUP(2);
          SETRANGE("Manager No.",RecGEmployee."No.");
          IF FINDFIRST THEN;
          FILTERGROUP(0);
          FiltreSupHearchic:=RecGEmployee."No.";
          NomSupHearchic:=RecGEmployee."First Name"+RecGEmployee."Last Name";
          Trimestre:=ROUND(DATE2DMY(WORKDATE,2)/3,1,'>');
        END;*/
        Rec.FilterGroup(2);
        Rec.SetRange(Blocked, false);
        Rec.SetRange("Relation de travail", rec."relation de travail"::Contractuel);
        Rec.FilterGroup(0);
        Mois := Date2dmy(WorkDate, 2) - 1;

    end;

    var
        FiltreSupHearchic: Code[20];
        NomSupHearchic: Text[50];
        RecGEmployee: Record Employee;
        Mois: Option Janvier,"Févrié",Mars,Avril,Mai,Juin,Juillet,"Aôut","Séptembre",Octobre,Novembre,"Décembre";
        Date: Date;
        CodGNote: Code[20];
        RecGParamGRH: Record "Human Resources Setup";
        Text001: label 'Les notes %1  pour le salarié %2 sont déjà validées pour ce mois.';
        Text002: label 'La note ne doit pas dépasser %1.';
        Text003: label 'Validation des notes avec succé.';
        Text004: label 'Voulez-vous valider ces notes?';
        FiltreSalarie: Text[30];
        Text005: label 'Aucune lignes n''est sélectionée.';
        Text006: label 'Vous devez renseigner le champ Type note.';
        FiltreGrpComptaSalarie: Text[30];
        [InDataSet]
        "Note PrimeVisible": Boolean;


    procedure Valider()
    var
        // RecLEcritureSanction: Record "Camion Carriere";
        // RecLEcritureSanction2: Record "Camion Carriere";
        // RecLEcritureSanction3: Record "Camion Carriere";
        // RecLNoteSetUp: Record "Chantier Carriere";
        RecLSalarie: Record Employee;
    begin
        //GL2024
        IF CodGNote = '' THEN
            ERROR(Text006);
        IF CONFIRM(Text004) THEN BEGIN
            CurrPage.SETSELECTIONFILTER(RecLSalarie);
            IF RecLSalarie.FINDFIRST THEN BEGIN
                REPEAT
                // IF RecLNoteSetUp.GET(CodGNote) THEN BEGIN
                /*   RecLEcritureSanction2.RESET;
                   RecLEcritureSanction2.SETRANGE("Code Note", CodGNote);
                   RecGParamGRH.GET;
                   IF CodGNote = RecGParamGRH."Code note prime" THEN
                       RecLEcritureSanction.INIT;
                   IF RecLEcritureSanction2.FINDLAST THEN
                       RecLEcritureSanction."N° Sequences" := RecLEcritureSanction2."N° Sequences" + 1
                   ELSE
                       RecLEcritureSanction."N° Sequences" := 1;
                   RecLEcritureSanction."Code Note" := CodGNote;
                   RecLEcritureSanction.Date := WORKDATE;
                   RecLEcritureSanction."Nombre Fois" := 1;
                   RecLEcritureSanction.Annee := DATE2DMY(WORKDATE, 3);
                   RecLEcritureSanction.Trimestre := (Mois DIV 3) + 1;
                   RecLEcritureSanction.Mois := Mois;
                   RecLEcritureSanction.Periodicite := RecLNoteSetUp.Periodicity;
                   IF RecLSalarie."Note Prime" <= RecLNoteSetUp."Echele Notation" THEN
                       RecLEcritureSanction."Points Sanctionees" := (RecLSalarie."Note Prime" - RecLNoteSetUp."Echele Notation")
                   ELSE
                       ERROR(STRSUBSTNO(Text002, RecLNoteSetUp."Echele Notation"));
                   RecLEcritureSanction."Employee No." := RecLSalarie."No.";
                   RecLEcritureSanction3.RESET;
                   RecLEcritureSanction3.SETRANGE("Employee No.", RecLSalarie."No.");
                   RecLEcritureSanction3.SETRANGE(Annee, DATE2DMY(WORKDATE, 3));
                   RecLEcritureSanction3.SETRANGE(Mois, Mois);
                   RecLEcritureSanction3.SETRANGE("Code Note", CodGNote);
                   RecLEcritureSanction3.SETRANGE("Code Motif", '');
                   //RecLEcritureSanction3.SETRANGE(User,USERID);
                   IF RecLEcritureSanction3.FINDFIRST THEN
                       ERROR(STRSUBSTNO(Text001, CodGNote, RecLSalarie."No."))
                   ELSE BEGIN
                       RecLEcritureSanction.INSERT;
                       RecLSalarie."Note Prime" := 0;
                       RecLSalarie.MODIFY;
                   END;
                   */
                //  END;
                UNTIL RecLSalarie.NEXT = 0;
            END
            ELSE
                ERROR(Text005);
            MESSAGE('%1', Text003);
        END;

    end;

    local procedure FiltreSupHearchicOnAfterValida()
    begin
        CurrPage.Update;
    end;

    local procedure CodGNoteOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure FiltreSalarieOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure FiltreGrpComptaSalarieOnAfterV()
    begin
        CurrPage.Update;
    end;
}

