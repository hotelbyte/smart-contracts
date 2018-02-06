pragma solidity ^0.4.19;

library AddressSet {

    struct Data {
        address[] array;
    }

    // Note that the first parameter is of type "storage
    // reference" and thus only its storage address and not
    // its contents is passed as part of the call.  This is a
    // special feature of library functions.  It is idiomatic
    // to call the first parameter `self`, if the function can
    // be seen as a method of that object.
    function insert(Data storage self, address value)
    public
    returns (bool)
    {
        if (contains(self, value)) {// already there
            return false;
        }
        self.array.push(value);
        return true;
    }

    function remove(Data storage self, address value)
    public
    returns (bool)
    {
        uint i = indexOf(self, value);
        if (i == 0) {// not there
            return false;
        }
        while (i < self.array.length - 1) {
            self.array[i] = self.array[i + 1];
            i++;
        }
        self.array.length--;
        return true;
    }

    function contains(Data storage self, address value)
    public
    view
    returns (bool)
    {
        if (indexOf(self, value) != 0) {
            return true;
        } else {
            return false;
        }
    }

    function indexOf(Data storage self, address value)
    private
    view
    returns (uint)
    {
        uint i = 0;
        while (self.array[i] != value && i < self.array.length) {
            i++;
        }
        return i;
    }
}
