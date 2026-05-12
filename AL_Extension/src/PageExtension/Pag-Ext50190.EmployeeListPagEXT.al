PageExtension 50190 "Employee List_PagEXT" extends "Employee List"

{

    layout
    {
        modify(Control1)
        {
            Editable = false;
        }
        modify("Job Title")
        {
            Editable = false;
        }
        modify("Phone No.")
        {
            Editable = false;
        }
        modify("Search Name")
        {
            Editable = false;
        }
        modify("Balance (LCY)")
        {
            Editable = false;
        }
        modify(Comment)
        {
            Editable = false;
        }
        modify("Middle Name")
        {
            Visible = false;
        }
        modify("Last Name")
        {
            Visible = false;
        }
        modify("First Name")
        {
            Caption = 'Nom Et Prénom';
        }

        addafter("First Name")
        {

            field(Fonction; Rec.Fonction)
            {
                ApplicationArea = all;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = all;
            }
            field("Catégorie"; Rec."Catégorie")
            {
                ApplicationArea = all;
            }
            field(Echelons; Rec.Echelons)
            {

            }
            field("Basis salary"; Rec."Basis salary")
            {
                ApplicationArea = all;
                Style = Attention;
                StyleExpr = true;
            }

            field("Nombre de Charge"; Rec."Nombre de Charge")
            {
                ApplicationArea = all;
            }
            field("Advances balance"; Rec."Advances balance")
            {
                ApplicationArea = all;

            }
            field("Loans balance"; Rec."Loans balance")
            {
                ApplicationArea = all;
            }
            field("date debut contrat"; Rec."date debut contrat")
            {
                ApplicationArea = all;
            }
            field("Salaire Brut"; DecSBRUT)
            {
                ApplicationArea = all;
            }

            // field("Salaire Brut"; Rec."Salaire Brut")
            // {
            //     ApplicationArea = all;
            // }
            field("Employee's type"; Rec."Employee's type")
            {
                ApplicationArea = all;
            }
            field("Employment Date"; Rec."Employment Date")
            {
                ApplicationArea = all;
            }

            field("Days off -"; Rec."Days off -")
            {
                ApplicationArea = all;
            }
            field("Days off +"; Rec."Days off +")
            {
                ApplicationArea = all;
            }
            field("Days off ="; Rec."Days off =")
            {
                ApplicationArea = all;
            }
            field("No. 2"; Rec."No. 2")
            {
                ApplicationArea = all;
                Visible = false;
            }

            // field(Affectation; Rec.Affectation)
            // {
            //     ApplicationArea = all;
            // }
            // field("Deccription Affectation"; Rec."Deccription Affectation")
            // {
            //     ApplicationArea = all;
            // }
            // field(Zone; Rec.Zone)
            // {
            //     ApplicationArea = all;
            // }
            /* field(Address; Rec.Address)
             {
                 ApplicationArea = all;
             }*/
            // field("N° CIN"; Rec."N° CIN")
            // {
            //     ApplicationArea = all;
            // }
            // field("Nombre Enfant"; Rec."Nombre Enfant")
            // {
            //     ApplicationArea = all;
            // }
            // field(Qualification; Rec.Qualification)
            // {
            //     ApplicationArea = all;
            // }
            // field("Description Qualification"; Rec."Description Qualification")
            // {
            //     ApplicationArea = all;
            // }

        }
    }

    actions
    {
        modify("E&mployee")
        {
            Visible = false;
        }
        addafter("Sent Emails")
        {
            action(FillNo2)
            {
                Caption = 'Générer No. 2';
                ApplicationArea = All;
                Image = NumberSetup;
                Visible = false;

                trigger OnAction()
                var
                    Zeros: Text;
                    Len: Integer;
                    Emp: Record Employee;
                begin
                    Emp.Reset();
                    if Emp.FindSet() then
                        repeat
                            // Calcul longueur du No.
                            Len := StrLen(Emp."No.");

                            // Générer les zéros à gauche
                            if Len < 5 then
                                Zeros := PadStr('', 5 - Len, '0')
                            else
                                Zeros := '';

                            // Mise à jour du champ "No. 2"
                            Emp."No. 2" := Zeros + Emp."No.";
                            Emp.Modify(true);
                        until Emp.Next() = 0;

                    Message('Tous les champs "No. 2" ont été mis à jour !');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        rec.CALCFIELDS("Somme Indemnités");
        DecSBRUT := rec."Somme Indemnités" + rec."Basis salary";
        // SalaireBrut := 0;
        // rec.CALCFIELDS("Total Indemnité Par Defaut");
        // IF rec."Salaire De Base Horaire" = 0 THEN
        //     SalaireBrut := rec."Total Indemnité Par Defaut" + rec."Basis salary"
        // ELSE
        //     SalaireBrut := rec."Total Indemnité Par Defaut" + rec."Salaire De Base Horaire";
    end;

    trigger OnOpenPage()
    var
        RecLUserSetup: Record "User Setup";
    begin
        /* GL2024  SourceTableView = WHERE(Blocked = CONST(false),
                         BR = CONST(false));*/
        // Rec.FilterGroup(0);
        // rec.SetRange(Blocked, false);
        //  rec.SetRange(BR, false);
        //    Rec.FilterGroup(2);
        RecLUserSetup.get(UserId);
        if not RecLUserSetup."Modif Salarie" then
            Error('Cette page est non autorisée');


        // Tri croissant sur le champ "No. 2"
        Rec.SetCurrentKey("No. 2");
        Rec.Ascending(true);
    end;

    VAR
        Sal: Record Employee;
        DecSBRUT: Decimal;
        SalaireBrut: Decimal;


}