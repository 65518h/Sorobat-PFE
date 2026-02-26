xmlport 50000 "Import Inventaire"
{
    FieldSeparator = ';';
    Format = VariableText;
    RecordSeparator = '<NewLine>';
    TableSeparator = '<NewLine><NewLine>';
    Direction = Import;
    // TransactionType = UpdateNoLocks;
    // UseRequestPage = true;

    schema
    {
        textelement(NodeName1)
        {
            tableelement(ItemJournalLine; "Item Journal Line")
            {
                // AutoSave = true;
                // AutoUpdate = true;
                textelement(Article) { }
                textelement(Magasin)
                {

                    MinOccurs = Zero;
                }
                textelement(Qte) { MinOccurs = Zero; }
                trigger OnAfterGetRecord()
                var
                    QteEvaluated: Decimal;
                begin
                    Evaluate(QteEvaluated, Qte);
                    Message('Article %1 Magasin %2 Qte %3', Article, Magasin, QteEvaluated);
                    RecItemJournalLine.RESET;
                    RecItemJournalLine3.SETRANGE("Journal Template Name", Journal);
                    RecItemJournalLine3.SETRANGE("Journal Batch Name", Batch);
                    IF DateComptabilisation = 0D THEN IF RecItemJournalLine3.FINDFIRST THEN DateComptabilisation := RecItemJournalLine3."Posting Date";
                    RecItemJournalLine.RESET;
                    RecItemJournalLine.SETRANGE("Journal Template Name", Journal);
                    RecItemJournalLine.SETRANGE("Journal Batch Name", Batch);
                    RecItemJournalLine.SETRANGE("Item No.", Article);
                    RecItemJournalLine.SETRANGE("Location Code", Magasin);
                    IF RecItemJournalLine.FINDFIRST THEN BEGIN
                        RecItemJournalLine.VALIDATE("Qty. (Phys. Inventory)", QteEvaluated);
                        RecItemJournalLine.Traité := TRUE;
                        RecItemJournalLine.MODIFY;
                    END
                    ELSE BEGIN
                        Compteur += 10000;
                        RecItemJournalLine2."Journal Template Name" := 'INVOUVERTU';
                        RecItemJournalLine2."Journal Batch Name" := 'INVOUVERTU';
                        RecItemJournalLine."Document No." := 'INV-' + FORMAT(DateComptabilisation);
                        RecItemJournalLine2."Line No." := Compteur;
                        RecItemJournalLine2."Posting Date" := DateComptabilisation;
                        RecItemJournalLine2."Entry Type" := RecItemJournalLine2."Entry Type"::"Positive Adjmt.";
                        RecItemJournalLine2.VALIDATE("Item No.", Article);
                        RecItemJournalLine2.VALIDATE("Location Code", Magasin);
                        RecItemJournalLine2.VALIDATE(Quantity, QteEvaluated);
                        RecItemJournalLine2.INSERT;
                    END;
                end;

                trigger OnAfterInsertRecord()
                begin

                    IF Compteur > 0 THEN MESSAGE(Text001);
                end;




            }

        }

    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {


                }
            }
        }
    }

    procedure GetBatch(ParaJournal: Code[20]; ParaBatch: Code[20])
    begin
        Journal := ParaJournal;
        Batch := ParaBatch;
    end;

    var
        myInt: Integer;

        RecItemJournalLine: Record "Item Journal Line";
        RecItemJournalLine2: Record "Item Journal Line";
        RecItemJournalLine3: Record "Item Journal Line";
        num: Code[20];
        description: Text[100];
        //  Article: Code[20];
        // Magasin: Code[20];
        //Qte: Decimal;
        Journal: Code[20];
        Batch: Code[20];
        Compteur: Integer;
        DateComptabilisation: Date;

        Text001: Label 'Des Lignes Ont Etaient Inserées Dans La Feuille Inventaire Ouverture, N''oubliez pas De Les Validés';
}