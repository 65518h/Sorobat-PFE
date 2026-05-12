Page 50007 "Bureau Ord Diff Dest. Detail"
{
    DelayedInsert = false;
    DeleteAllowed = true;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Bureau Ordre Diffusion";
    Caption = 'Bureau Ord Diff Dest. Detail';




    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                /*   field("Document N°"; rec."Document N°")
                   {
                       ApplicationArea = all;
                       Editable = false;
                   }*/
                field("suivi"; rec.suivi)
                {
                    ApplicationArea = all;
                }
                field("action"; rec.action)
                {
                    ApplicationArea = all;

                }
                field("type Destination"; rec."type Destination")
                {
                    ApplicationArea = all;
                    //  Visible = false;
                }
                field("Action Faite Le"; rec."Action Faite Le")
                {
                    ApplicationArea = all;
                }
                field("Action Faite Par"; rec."Action Faite Par")
                {
                    ApplicationArea = all;
                    // Visible = false;
                }
                field("Destinataire"; rec.Destinataire)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Remarque"; rec.Remarque)
                {
                    ApplicationArea = all;
                    //  Editable = false;
                }

                /*    field("N° Ligne"; rec."N° Ligne")
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field("N° Fournisseur"; rec."N° Fournisseur")
                    {
                        ApplicationArea = all;
                    }
                    field("Nom Fournisseur"; rec."Nom Fournisseur")
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field("Adresse Fournisseur"; rec."Adresse Fournisseur")
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field("Type identifiant"; rec."Type identifiant")
                    {
                        ApplicationArea = all;
                        Editable = false;
                        Style = Strong;
                        StyleExpr = true;
                    }
                    field("Matricule Fiscale"; rec."Matricule Fiscale")
                    {
                        ApplicationArea = all;
                        Editable = false;
                        Style = Strong;
                        StyleExpr = true;
                    }
                    field("Numero Facture"; rec."Numero Facture")
                    {
                        ApplicationArea = all;
                        Style = Strong;
                        StyleExpr = true;

                        trigger OnValidate()
                        begin
                            BureauOrdreDiffusion.Reset;
                            //BureauOrdreDiffusion.SETRANGE("Document N°","Document N°");
                            BureauOrdreDiffusion.SetRange("N° Fournisseur", rec."N° Fournisseur");
                            BureauOrdreDiffusion.SetRange("Numero Facture", rec."Numero Facture");
                            if BureauOrdreDiffusion.FindFirst then Error(Text0001);
                        end;
                    }
                    field("Date Facture Fournisseur"; rec."Date Facture Fournisseur")
                    {
                        ApplicationArea = all;
                        Style = Strong;
                        StyleExpr = true;
                    }
                    field("Numero Commande"; rec."Numero Commande")
                    {
                        ApplicationArea = all;
                    }
                    field("Montant HT"; rec."Montant HT")
                    {
                        ApplicationArea = all;
                        DecimalPlaces = 3 : 3;
                    }
                    field("Montant TVA"; rec."Montant TVA")
                    {
                        ApplicationArea = all;
                        DecimalPlaces = 3 : 3;
                    }
                    field("Montant Timbre"; rec."Montant Timbre")
                    {
                        ApplicationArea = all;
                        DecimalPlaces = 3 : 3;
                    }
                    field("Montant TTC"; rec."Montant TTC")
                    {
                        ApplicationArea = all;
                        DecimalPlaces = 3 : 3;
                    }*/
            }
        }
    }

    actions
    {

    }
    trigger OnOpenPage()
    begin
        Rec.RESET;
        IF Rec.FINDFIRST THEN
            REPEAT
                IF (Rec."Action Faite Par" = USERID) OR (Rec.Destinataire = USERID) THEN Rec.MARK := TRUE
            UNTIL Rec.NEXT = 0;
        Rec.MARKEDONLY(TRUE);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rec."Référence Ligne" := rec."Document N°" + ' - ' + Format(rec."N° Ligne");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*  BureauOrdreDiffusion.SetRange("Document N°", rec."Document N°");
          if BureauOrdreDiffusion.FindLast then begin
              rec."N° Ligne" := BureauOrdreDiffusion."N° Ligne" + 10000;

          end
          else
              rec."N° Ligne" := 10000;*/
    end;

    var
        BureauOrdreDiffusion: Record "Bureau Ordre Diffusion";
        Text0001: label 'Invoice Number already exists for this svendor !!';
}

