Page 50238 "Correspandance Rapport DG"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Correspondan Rapport DG";
    SourceTableView = sorting(Marché, Niveau);
    ApplicationArea = all;
    Caption = 'Correspandance Rapport DG';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Marché"; REC.Marché)
                {
                    ApplicationArea = all;
                    Editable = true;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Désignation"; REC.Désignation)
                {
                    ApplicationArea = all;
                    Editable = true;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Correspandance Decompte"; REC."Correspandance Decompte")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Correspandance Article"; REC."Correspandance Article")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Niveau; REC.Niveau)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Type Diff"; REC."Type Diff")
                {
                    ApplicationArea = all;
                }
                field("Taux Foisonnement"; REC."Taux Foisonnement")
                {
                    ApplicationArea = all;
                }
                field("Type Operation"; REC."Type Operation")
                {
                    ApplicationArea = all;
                }
                field("Prix Marché"; REC."Prix Marché")
                {
                    ApplicationArea = all;
                }
                field(Coeficion; REC.Coeficion)
                {
                    ApplicationArea = all;
                }
                field("Regroupement Difference"; REC."Regroupement Difference")
                {
                    ApplicationArea = all;
                }
                field(Type; REC.Type)
                {
                    ApplicationArea = all;
                }
                field(Observation; REC.Observation)
                {
                    ApplicationArea = all;
                }
                field("Regroupement Bilan"; REC."Regroupement Bilan")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Mise à Jour")
            {
                ApplicationArea = all;
                Caption = 'Mise à Jour';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    RecCorrespondanRapportDG.SetRange(Marché, 'MC-133');
                    if RecCorrespondanRapportDG.FindFirst then
                        repeat
                            SumQuantitéMateriaux := 0;
                            if RecCorrespondanRapportDG."Correspandance Article" <> '' then begin
                                RecItemLedgerEntry.Reset;
                                //   RecItemLedgerEntry.SetRange(Chantier, RecCorrespondanRapportDG.Marché);
                                RecItemLedgerEntry.SetFilter("Item No.", RecCorrespondanRapportDG."Correspandance Article");
                                RecItemLedgerEntry.SetRange("Entry Type", RecItemLedgerEntry."entry type"::Purchase);
                                if RecItemLedgerEntry.FindFirst then
                                    repeat
                                        SumQuantitéMateriaux := SumQuantitéMateriaux + RecItemLedgerEntry.Quantity;
                                    until RecItemLedgerEntry.Next = 0;

                                RecDetailRapportDG.Reset;
                                RecDetailRapportDG.SetRange(RecDetailRapportDG.Marché, RecCorrespondanRapportDG.Marché);
                                RecDetailRapportDG.SetRange(RecDetailRapportDG.Niveau, RecCorrespondanRapportDG.Niveau);
                                if RecDetailRapportDG.FindFirst then begin
                                    if RecCorrespondanRapportDG."Type Operation" = 1 then begin
                                        RecDetailRapportDG."Quantité Livré" := SumQuantitéMateriaux / RecCorrespondanRapportDG.Coeficion;
                                    end
                                    else
                                        if RecCorrespondanRapportDG."Type Operation" = 2 then begin
                                            RecDetailRapportDG."Quantité Livré" := SumQuantitéMateriaux * RecCorrespondanRapportDG.Coeficion;
                                        end
                                        else begin
                                            RecDetailRapportDG."Quantité Livré" := SumQuantitéMateriaux;
                                        end;

                                    RecDetailRapportDG.Modify;
                                end;
                            end;
                        until RecCorrespondanRapportDG.Next = 0;
                end;
            }
        }
    }

    var
        RecItemLedgerEntry: Record "Item Ledger Entry";
        RecCorrespondanRapportDG: Record "Correspondan Rapport DG";
        "SumQuantitéMateriaux": Decimal;
        RecDetailRapportDG: Record "Detail Rapport DG";
}

