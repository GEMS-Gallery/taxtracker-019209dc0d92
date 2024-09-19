import Func "mo:base/Func";
import Text "mo:base/Text";

// backend/main.mo
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Option "mo:base/Option";

actor {

  // Define the TaxPayer record type
  type TaxPayer = {
    tid: Text;
    firstName: Text;
    lastName: Text;
    address: Text;
  };

  // Stable variable to store taxpayer records
  stable var taxpayers: [TaxPayer] = [];

  // Function to add a new taxpayer record
  public func addTaxPayer(tid: Text, firstName: Text, lastName: Text, address: Text): async Text {
    // Check if the TID already exists
    let existing = Array.find<TaxPayer>(taxpayers, func (tp: TaxPayer) { tp.tid == tid });
    switch (existing) {
      case (null) {
        // Add new record if TID does not exist
        taxpayers := Array.append<TaxPayer>(taxpayers, [{ tid; firstName; lastName; address }]);
        return "TaxPayer added successfully.";
      };
      case (?_) {
        return "TaxPayer with this TID already exists.";
      };
    }
  };

  // Function to get all taxpayer records
  public query func getAllTaxPayers(): async [TaxPayer] {
    return taxpayers;
  };

  // Function to search for a taxpayer by TID
  public query func searchTaxPayerByTID(tid: Text): async ?TaxPayer {
    return Array.find<TaxPayer>(taxpayers, func (tp: TaxPayer) { tp.tid == tid });
  };
}
