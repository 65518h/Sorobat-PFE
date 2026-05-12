Codeunit 8001521 "BAR : Initialization"
{
    //GL2024  ID dans Nav 2009 : "8001600"
    // //+RAP+RAPPRO GESWAY 26/06/02 Init codes interbancaires/motifs, modes de rapprochement, des états de rapprochement.


    trigger OnRun()
    begin
        if not ParamRappro.Get then
            ParamRappro.Insert;

        i := 0;
        if Societe.Find('-') then
            repeat
                if not CpteBancaire.Get(i) then begin   //Total
                    CpteBancaire."Bank Account Internal No." := i;
                    CpteBancaire.Company := Societe.Name;
                    CpteBancaire."Bank Account No." := TextTotal;
                    CpteBancaire."Excluded From Import" := true;
                    CpteBancaire.Iban := '';
                    CpteBancaire."SWIFT Code" := '';
                    CpteBancaire."Excluded From Cash Flow" := false;
                    CpteBancaire.Insert;
                end;

                if not CpteBancaire.Get(1 + i) then begin   //Client
                    CpteBancaire."Bank Account Internal No." := 1 + i;
                    CpteBancaire.Company := Societe.Name;
                    CpteBancaire."Bank Account No." := Clt.TableName;
                    CpteBancaire."Excluded From Import" := true;
                    CpteBancaire.Iban := '';
                    CpteBancaire."SWIFT Code" := '';
                    CpteBancaire."Excluded From Cash Flow" := false;
                    CpteBancaire.Insert;
                end;

                if not CpteBancaire.Get(2 + i) then begin   //Fournisseur
                    CpteBancaire."Bank Account Internal No." := 2 + i;
                    CpteBancaire.Company := Societe.Name;
                    CpteBancaire."Bank Account No." := Frn.TableName;
                    CpteBancaire."Excluded From Import" := true;
                    CpteBancaire.Iban := '';
                    CpteBancaire."SWIFT Code" := '';
                    CpteBancaire."Excluded From Cash Flow" := false;
                    CpteBancaire.Insert;
                end;

                if not CpteBancaire.Get(3 + i) then begin   //+RAP+VMP
                    CpteBancaire."Bank Account Internal No." := 3 + i;
                    CpteBancaire.Company := Societe.Name;
                    CpteBancaire."Bank Account No." := TextTitre;
                    CpteBancaire."Excluded From Import" := true;
                    CpteBancaire.Iban := '';
                    CpteBancaire."SWIFT Code" := '';
                    CpteBancaire."Excluded From Cash Flow" := false;
                    CpteBancaire.Insert;
                end;
                i += 4;
            until Societe.Next = 0;

        if ParamRappro."Default Bank No." = '' then
            Error(Text003);

        //Sécurité
        Securite.CreerSecurite(GroupeRappro, LireRappro, 0, 1, 0, 2000000001, 2000000001);
        Securite.CreerSecurite(GroupeRappro, LireRappro, 0, 1, 1, 8001600, 8001607);
        Securite.CreerSecurite(GroupeRappro, LireRappro, 0, 1, 1, 8001400, 8001407);
        Securite.CreerSecurite(GroupeRappro, LireRappro, 0, 1, 1, 231, 231);
        Securite.CreerSecurite(GroupeRappro, LireRappro, 0, 1, 1, 270, 270);
        Securite.CreerSecurite(GroupeRappro, LireRappro, 0, 1, 2, 271, 272);
        Securite.CreerSecurite(GroupeRappro, LireRappro, 0, 1, 1, 273, 274);
        Securite.CreerSecurite(GroupeRappro, LireRappro, 0, 1, 2, 275, 276);
        Securite.CreerSecurite(GroupeRappro, LireRappro, 0, 1, 1, 15, 15);

        RechercherValeur(ParamRappro."Default Bank No.", '01', 'Chèques payés', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '02', 'Remises de chèques mixtes', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '03', 'Chèques impayés', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '04', 'Versements espèces', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '05', 'Virements reçus', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '06', 'Virements émis', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '07', 'Domiciliation d''effets', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '08', 'Prélèvements et TIP domiciliés', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '09', 'Prélèvements et TIP émis', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '10', 'Prélèvements et TIP rejetés/imp.', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '11', 'Factures cartes de paiement/BAB-GAB', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '12', 'Rejet de virement', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '13', 'Virements de trésorerie reçus', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '14', 'Virements de trésorerie émis', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '15', 'Remises de chèques sur caisse', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '16', 'Remises de chèques sur rayon', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '17', 'Remises de chèques hors rayon', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '18', 'Autres Virements reçus', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '19', 'Virements à échéance émis E-2', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '20', 'Virements à échéance émis E-3', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '21', 'Autres Virements émis', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '22', 'TIP domiciliés', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '23', 'Prélèvements domiciliés', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '24', 'TIP émis', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '25', 'Prélèvements émis', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '26', 'TIP rejetés/impayés', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '27', 'Prélèvements rejetés/impayés', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '28', 'Factures cartes payées', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '29', 'Retrait DAB-GAB', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '30', 'Factures cartes remises', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '31', 'Remises d''effets à l''encaissement', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '32', 'Remise d''effet à l''escompte', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '33', 'Effets impayés', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '34', 'Incidents sur effets', InterBancaireMotif.Direction::Both, '');

        RechercherValeur(ParamRappro."Default Bank No.", '35', 'Remises de LCR/BOR à l''encaissement', InterBancaireMotif.Direction::Both, '')
        ;
        RechercherValeur(ParamRappro."Default Bank No.", '36', 'Remise de LCC à l''enc.', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '37', 'Remises de LCR/BOR à l''escompte', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '38', 'Remises de LCC à l''escompte', InterBancaireMotif.Direction::Both, '');

        RechercherValeur(ParamRappro."Default Bank No.", '41', 'Transfert vers/en provenance', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '42', 'Achats/ventes de devises', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '43', 'Autres opérations avec l''étranger', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '44', 'Transferts émis', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '45', 'Transferts reçus', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '46', 'Achats de devises au comptant', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '47', 'Ventes de devises au comptant', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '48', 'levé sur achats à terme', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '49', 'livraison sur vente à terme', InterBancaireMotif.Direction::Both, '');

        RechercherValeur(ParamRappro."Default Bank No.", '51', 'Achats et ventes de titres', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '52', 'Diverses opérations sur titres', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '53', 'Achats/souscriptions VM/BF', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '54', 'Ventes de VM/BF', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '56', 'Achats OPCVM', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '57', 'Ventes OPCVM', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '58', 'Achats TCN', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '59', 'Ventes TCN', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '61', 'Agios', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '62', 'Commissions et frais divers', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '63', 'Produits financiers', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '64', 'Commissions y compris taxes', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '65', 'Commissions hors taxes', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '66', 'Commissions non taxables', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '67', 'Taxes', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '68', 'Autres opé. avec l''étranger D', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '69', 'Autres opé. avec l''étranger C', InterBancaireMotif.Direction::Both, '');

        RechercherValeur(ParamRappro."Default Bank No.", '70', 'Charges financières', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '71', 'Tirage de crédits', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '72', 'Echéance de crédits', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '73', 'Emission de valeurs mobilières', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '74', 'Emission de titres de créances', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '75', 'Remboursement', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '76', 'Dépôt à terme', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '77', 'Echéance dépôt à terme', InterBancaireMotif.Direction::Both, '');

        RechercherValeur(ParamRappro."Default Bank No.", '80', 'Achats autres TC', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '81', 'Ventes autres TC', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '82', 'Contrats', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '83', 'Options', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '84', 'Achats bourses étrangères', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '85', 'Ventes bourses étrangères', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '86', 'Opérations sur titre', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '87', 'Revenus sur titres', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '88', 'Commissions et droits de garde', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '89', 'Remboursements impôts étrangers', InterBancaireMotif.Direction::Both, '');

        RechercherValeur(ParamRappro."Default Bank No.", '91', 'Opérations diverses', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '92', 'Centralisation de recettes', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '93', 'Centralisation de dépenses', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '94', 'Centralisation de trésorerie Crédit', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '95', 'Centralisation de trésorerie Débit', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '96', 'Annulations et régularisations', InterBancaireMotif.Direction::Both, '');
        RechercherValeur(ParamRappro."Default Bank No.", '99', 'Annulations et régularisations', InterBancaireMotif.Direction::Both, '');

        RechercherMode('Montant', 40);
        RechercherMode('N° document', 10);
        RechercherMode('N° doc. externe', 20);
        RechercherMode('Totaux montants', 30);
    end;

    var
        ParamRappro: Record "BAR : Setup";
        InterBancaireMotif: Record "BAR : Interbank Code";
        ModeRappro: Record "BAR : Reconciliation Mode";
        Securite: Codeunit Security;
        GroupeRappro: label 'BAR - Read';
        LireRappro: label 'Read Reconciliation';
        Text003: label 'You must fill default bank account no. in "Reconciliation Setup".';
        CpteBancaire: Record "BAR : Bank Account";
        Clt: Record Customer;
        Frn: Record Vendor;
        TextTotal: label 'TOTAL';
        TextTitre: label 'STOCK';
        Societe: Record Company;
        i: Integer;


    procedure RechercherValeur(CodeCompteBancaire: Code[20]; InterBancaire: Text[2]; NomChamp: Text[50]; SensLocal: Option Debit,Credit,Both; Motif: Code[10])
    begin
        with InterBancaireMotif do begin
            SetRange("Bank Account No.", CodeCompteBancaire);
            SetRange("Interbank Code", InterBancaire);
            SetRange(Direction, SensLocal);
            if not Find('-') then begin
                Init;
                "Bank Account No." := CodeCompteBancaire;
                "Interbank Code" := InterBancaire;
                Direction := SensLocal;
                "Reason Code" := Motif;
                Description := NomChamp;
                Insert;
            end;
        end;
    end;


    procedure RechercherMode(ModeR: Text[30]; NoInterne: Integer)
    begin
        with ModeRappro do begin
            SetRange("Reconciliation Mode", ModeR);
            SetRange("Internal No.", NoInterne);
            if not Find('-') then begin
                Init;
                "Reconciliation Mode" := ModeR;
                "Internal No." := NoInterne;
                Insert;
            end;
        end;
    end;
}

