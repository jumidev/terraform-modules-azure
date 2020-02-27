# Storage Container

Module to create an Azure storage continer is a given account. Storage account will enable encryption of file and blob and require https, these options are not possible to change.

## Events

It is also possible to connect Event Grid subscriptions to storage account and send event to an Event Hub. This requires the `events` variable to be set. Since variable object doesn´t support optional properties it uses `any` instead. The input object looks like this:

```terraform
events = [
    {
        name = required
        event_delivery_schema = optional(string)
        topic_name = optional(string)
        labels = optional(list(string))
        eventhub_id = required

        filters = optional({
            subject_begins_with = optional(string)
            subject_ends_with = optional(string)
        })
    }
]
```
