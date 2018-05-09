# -*- coding: utf-8 -*-

"""
    Blah blah
"""

import os

# We want to seamlessy run our API both locally and on Heroku. If running on
# Heroku, sensible DB connection settings are stored in environment variables.
# mongodb://<dbuser>:<dbpassword>@ds161890.mlab.com:61890/materias_componentes


MONGO_HOST = 'ds161890.mlab.com'
MONGO_PORT = 61890
MONGO_USERNAME = 'moralesarias94'
MONGO_PASSWORD = 'juaz1212'
MONGO_DBNAME = 'materias_componentes'
MONGO_QUERY_BLACKLIST = ['$where']
#DEBUG = bool(int(os.environ.get('DEBUG', 1)))


# Enable reads (GET), inserts (POST) and DELETE for resources/collections
# (if you omit this line, the API will default to ['GET'] and provide
# read-only access to the endpoint).
RESOURCE_METHODS = ['GET', 'POST', 'DELETE']

# Enable reads (GET), edits (PATCH) and deletes of individual productos
# (defaults to read-only item access).
ITEM_METHODS = ['GET', 'PATCH', 'DELETE']

# We enable standard client cache directives for all resources exposed by the
# API. We can always override these global settings later.
CACHE_CONTROL = 'max-age=20'
CACHE_EXPIRES = 20

# Our API will expose two resources (MongoDB collections): 'people' and
# 'works'. In order to allow for proper data validation, we define beaviour
# and structure.

materias = {
    # Schema definition, based on Cerberus grammar. Check the Cerberus project
    # (https://github.com/pyeve/cerberus) for details.
    'schema': {
        'nombre': {
            'type': 'string',
            'required': True,
        },
        'notas': {
            'type': 'list',
            'schema': {
                'type': 'float'
            },
            'required' : True
        }
    }
}

# streams = {
#     # Schema definition, based on Cerberus grammar. Check the Cerberus project
#     # (https://github.com/pyeve/cerberus) for details.
#     'schema': {
#         'device': {
#             'type': 'string',
#             'required': True,
#             'minlength': 5,
#         },
#         'dt': {
#             'type': 'string',
#             'required': True,
#         },
#         'variable': {
#             'type': 'string',
#             'required': True,
#         },
#         'values': {
#             'type': 'dict',
#             'required': True,
#             'keyschema': {'type': 'float'},
#             'valueschema': {'type': 'string'},
#         },
#         'location': {
#             'required': False,
#             'type': 'dict',
#             'schema': {
#                 'lat': {
#                     'type': 'float',
#                     'required': True,
#                 },
#                 'lon': {
#                     'type': 'float',
#                     'required': True,
#                 },
#             },
#         },

#     }
# }


# The DOMAIN dict explains which resources will be available and how they will
# be accessible to the API consumer.
DOMAIN = {
    'materias': materias,
}

X_DOMAINS = '*'