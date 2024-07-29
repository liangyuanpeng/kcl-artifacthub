import jsonpatch

data = {
        "labels": {
          "org.io/team-name": "core"
        }
        "firstName": "John",
        "lastName": "Doe",
        "age": 30,
        "address": {
            "streetAddress": "1234 Main St",
            "city": "New York",
            "state": "NY",
            "postalCode": "10001"
        },
        "phoneNumbers": [
            {
                "type": "home",
                "number": "212-555-1234"
            },
            {
                "type": "work",
                "number": "646-555-5678"
            }
        ]
    }

newobj=remove_obj(data, "phoneNumbers/1/type")
#print(newobj)